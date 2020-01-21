FROM gcc-with-sonar-build-wrapper:latest

LABEL maintainer="falko.schwabe@googlemail.com"
LABEL version="1.0.0"
LABEL description="Provides a cross-compile environment for windows x64."

RUN apt-get update \
  && apt-get install -y --no-install-recommends python3 python3-pip libglew-dev

RUN pip3 install cmake
