#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

git -C /home/alpine/aports pull
abuild-keygen -a -i -n

exec $@
