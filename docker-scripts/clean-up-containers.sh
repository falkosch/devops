#!/usr/bin/env bash

docker ps --filter=status=exited --filter=status=created -q
docker rm $(docker ps --filter=status=exited --filter=status=created -q)
