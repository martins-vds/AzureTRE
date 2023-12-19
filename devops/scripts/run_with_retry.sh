#!/bin/bash

set -e -o pipefail

retry_count="${1}"
command="${*:2}"

number_of_attempts=0

until ${command} 2>/dev/null; do
  number_of_attempts=$((number_of_attempts + 1))

  if ((number_of_attempts == retry_count)); then
    echo "All attempts to run the command \"${command}\" have failed."
    exit 1
  else
    echo "Attempt ${number_of_attempts} to run the command \"${command}\" has failed."
  fi
done
