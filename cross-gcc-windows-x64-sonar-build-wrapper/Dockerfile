FROM gcc-with-sonar-build-wrapper:latest

LABEL maintainer="falko.schwabe@googlemail.com"
LABEL version="1.0.0"
LABEL description="Provides a cross-compile environment for windows x64."

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
        python3 \
        python3-pip \
        python3-setuptools \
        gcovr lcov

RUN pip3 install cmake==3.13.3 wheel

ENV CONAN_USER_HOME /conan

RUN mkdir -p ${CONAN_USER_HOME}/.conan \
  && chmod -R 777 ${CONAN_USER_HOME} \
  && pip3 install conan \
  && conan profile new default --detect \
  && conan remote add bincrafters https://api.bintray.com/conan/bincrafters/public-conan

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
        libglew-dev \
        mingw-w64 \
        mingw-w64-common \
        mingw-w64-tools \
        mingw-w64-x86-64-dev
