#!/usr/bin/env bash

LST=$(docker ps --filter=status=exited --filter=status=created -q)
if test -z "${LST}"
then
    echo "Containers seem to be clean."
    docker ps -a
else
    docker rm $(LST)
fi
