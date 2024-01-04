import json
import uuid
from typing import List, Tuple

from azure.cosmos.aio import CosmosClient
from pydantic import parse_obj_as
from db.repositories.resources_history import ResourceHistoryRepository
from models.domain.resource_template import ResourceTemplate
from models.domain.authentication import User

from db.errors import EntityDoesNotExist
from db.repositories.resource_templates import ResourceTemplateRepository
from db.repositories.resources import ResourceRepository, IS_NOT_DELETED_CLAUSE
from models.domain.resource import ResourceType
from models.domain.user_resource import UserResource
from models.schemas.resource import ResourcePatch
from models.schemas.user_resource import UserResourceInCreate

from services.logging import logger

class UserResourceRepository(ResourceRepository):
    @classmethod
    async def create(cls, client: CosmosClient):
        cls = UserResourceRepository()
        await super().create(client)
        return cls

    @staticmethod
    def user_resources_query(workspace_id: str, service_id: str):
        return f'SELECT * FROM c WHERE c.resourceType = "{ResourceType.UserResource}" AND c.parentWorkspaceServiceId = "{service_id}" AND c.workspaceId = "{workspace_id}"'

    @staticmethod
    def active_user_resources_query(workspace_id: str, service_id: str):
        return f'SELECT * FROM c WHERE {IS_NOT_DELETED_CLAUSE} AND c.resourceType = "{ResourceType.UserResource}" AND c.parentWorkspaceServiceId = "{service_id}" AND c.workspaceId = "{workspace_id}"'

    def get_parent_workspace_properties(self, properties: dict, parent_workspace_properties: dict) -> dict:
        """
        returns a dict of parent workspace properties that are required by the template
        """

        parent_prefix = "parent_"
        properties_copy = {**properties}

        if not parent_workspace_properties:
            return properties_copy

        parent_property_keys = [key for key in properties_copy.keys() if key.startswith("parent_")]

        if parent_property_keys:
            for key in parent_property_keys:
                parent_property_name = key[len(parent_prefix):]
                if parent_property_name in parent_workspace_properties:
                    properties_copy[key] = parent_workspace_properties[parent_property_name]

        return properties_copy


    async def create_user_resource_item(self, user_resource_input: UserResourceInCreate, workspace_id: str, parent_workspace_service_id: str, parent_template_name: str, parent_workspace_properties: dict, user_id: str, user_roles: List[str]) -> Tuple[UserResource, ResourceTemplate]:
        full_user_resource_id = str(uuid.uuid4())

        template = await self.validate_input_against_template(user_resource_input.templateName, user_resource_input, ResourceType.UserResource, user_roles, parent_template_name)

        # get parent workspace properties
        resource_parent_spec_parameters = self.get_parent_workspace_properties(user_resource_input.properties, parent_workspace_properties)

        # we don't want something in the input to overwrite the system parameters, so dict.update can't work.
        resource_spec_parameters = {**resource_parent_spec_parameters, **self.get_user_resource_spec_params()}

        logger.debug("Creating workspace user resource with id %s, template %s, and parameters %s", full_user_resource_id, template.id, json.dumps(resource_spec_parameters))

        user_resource = UserResource(
            id=full_user_resource_id,
            workspaceId=workspace_id,
            ownerId=user_id,
            parentWorkspaceServiceId=parent_workspace_service_id,
            templateName=user_resource_input.templateName,
            templateVersion=template.version,
            properties=resource_spec_parameters,
            resourcePath=f'/workspaces/{workspace_id}/workspace-services/{parent_workspace_service_id}/user-resources/{full_user_resource_id}',
            etag=''
        )

        return user_resource, template

    async def get_user_resources_for_workspace_service(self, workspace_id: str, service_id: str) -> List[UserResource]:
        """
        returns a list of "non-deleted" user resources linked to this workspace service
        """
        query = self.active_user_resources_query(workspace_id, service_id)
        user_resources = await self.query(query=query)
        return parse_obj_as(List[UserResource], user_resources)

    async def get_user_resource_by_id(self, workspace_id: str, service_id: str, resource_id: str) -> UserResource:
        query = self.user_resources_query(workspace_id, service_id) + f' AND c.id = "{resource_id}"'
        user_resources = await self.query(query=query)
        if not user_resources:
            raise EntityDoesNotExist
        return parse_obj_as(UserResource, user_resources[0])

    def get_user_resource_spec_params(self):
        return self.get_resource_base_spec_params()

    async def patch_user_resource(self, user_resource: UserResource, user_resource_patch: ResourcePatch, etag: str, resource_template_repo: ResourceTemplateRepository, resource_history_repo: ResourceHistoryRepository, parent_template_name: str, user: User, force_version_update: bool) -> Tuple[UserResource, ResourceTemplate]:
        # get user resource template
        user_resource_template = await resource_template_repo.get_template_by_name_and_version(user_resource.templateName, user_resource.templateVersion, ResourceType.UserResource, parent_service_name=parent_template_name)
        return await self.patch_resource(user_resource, user_resource_patch, user_resource_template, etag, resource_template_repo, resource_history_repo, user, force_version_update)
