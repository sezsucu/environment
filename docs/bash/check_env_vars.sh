#!/usr/bin/env bash

# checks if an environment variable is defined or not

if [[ -z "$ENV_NOT_DEFINED_AT_ALL" ]]; then
    echo "ENV_NOT_DEFINED_AT_ALL is not defined"
fi

if [[ ! -z "$USER" ]]; then
    echo "User name is $USER"
fi

ENV_ZERO_LENGTH=""
if [[ -z "$ENV_ZERO_LENGTH" ]]; then
    if [[ ! -n "$ENV_ZERO_LENGTH" ]]; then
        echo "ENV_ZERO_LENGTH is defined but has zero length"
    fi
fi

