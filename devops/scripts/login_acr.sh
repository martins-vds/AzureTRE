#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset

acr=$1

az acr login --name "$acr"
echo "##vso[task.setvariable variable=outcome;isoutput=true]success"
