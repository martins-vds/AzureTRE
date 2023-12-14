#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset

acr=$1
acr_login_outcome=$2
devcontainer_tag=$3

USER_UID=$(id -u)
USER_GID=$(id -g)

acr_domain_suffix=$(az cloud show --query suffixes.acrLoginServerEndpoint --output tsv)
CI_CACHE_ACR_URI="$acr"${acr_domain_suffix}
echo "##vso[task.setvariable variable=CI_CACHE_ACR_URI;isoutput=true]$CI_CACHE_ACR_URI"

docker_cache=()
if [ "$acr_login_outcome" = "success" ]; then
  docker_cache+=(--cache-from "$CI_CACHE_ACR_URI/tredev:$devcontainer_tag")
  docker_cache+=(--cache-from "$CI_CACHE_ACR_URI/tredev:latest")
fi

docker build . "${docker_cache[@]}" \
  -t "tredev:$devcontainer_tag" -f ".devcontainer/Dockerfile" \
  --build-arg BUILDKIT_INLINE_CACHE=1 --build-arg USER_UID="${USER_UID}" --build-arg USER_GID="${USER_GID}"

docker image tag tredev:"$devcontainer_tag" \
  "$CI_CACHE_ACR_URI/tredev:$devcontainer_tag"
