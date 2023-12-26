#!/bin/bash
acr=$1

az acr login --name "$acr"

lastExitCode=$?

if [ $lastExitCode -eq 0 ]; then
  echo "##vso[task.setvariable variable=outcome;isoutput=true]success"
else
  echo "##vso[task.setvariable variable=outcome;isoutput=true]failure"
fi

exit $lastExitCode
