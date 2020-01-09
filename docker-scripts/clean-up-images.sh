#!/usr/bin/env bash

LST=$(docker images -a --filter=dangling=true -q)
if test -z "${LST}"
then
    echo "Images seem to be clean"
    docker images -a
else
    docker rmi ${LST}
fi
