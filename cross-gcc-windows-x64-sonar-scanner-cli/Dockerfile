FROM gcc-with-sonar-scanner-cli:latest

LABEL maintainer="falko.schwabe@googlemail.com"
LABEL version="1.0.0"
LABEL description="Provides a cross-compile environment for windows x64."

USER root

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
        mingw-w64 \
        mingw-w64-common \
        mingw-w64-tools \
        mingw-w64-x86-64-dev

USER scanner-cli
