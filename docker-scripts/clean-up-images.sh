#!/usr/bin/env bash

docker images -a --filter=dangling=true -q
docker rmi $(docker images -a --filter=dangling=true -q)
