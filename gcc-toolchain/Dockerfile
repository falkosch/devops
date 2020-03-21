FROM buildpack-deps:focal

LABEL maintainer="falko.schwabe@googlemail.com"
LABEL version="1.0.0"
LABEL description="Provides an extended toolchain for GCC builds."


# Upgrade environment
RUN apt-get update \
    && apt-get upgrade -y --no-install-recommends \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


# Install prerequisites
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
            apt-utils \
            pylint \
            python3 \
            python3-pip \
            python3-setuptools \
            gcovr \
            lcov \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


# Install cross compiler suite for Windows target
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
            mingw-w64 \
            mingw-w64-common \
            mingw-w64-tools \
            mingw-w64-i686-dev \
            mingw-w64-x86-64-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


# Install common dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
            libglew-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


# Install cmake
RUN mkdir -p /tmp/pip \
    && pip3 install --cache-dir=/tmp/pip \
            cmake==3.13.2.post1 \
            wheel \
    && rm -rf /tmp/* \
    && cmake --version


# Install conan
ARG CONAN_USER_HOME=/opt/conan

ENV CONAN_USER_HOME=${CONAN_USER_HOME}

RUN mkdir -p ${CONAN_USER_HOME}/.conan \
    && mkdir -p /tmp/pip \
    && pip3 install --cache-dir=/tmp/pip \
            conan \
    && rm -rf /tmp/* \
    && conan profile new default --detect \
    && conan remote add bincrafters https://api.bintray.com/conan/bincrafters/public-conan \
    && chmod -R 777 ${CONAN_USER_HOME} \
    && conan --version


# Install NodeJS
ARG NODEJS_HOME=/opt/nodejs
ARG NODEJS_VERSION=v13.9.0
ARG NODEJS_ARCH=linux-x64

ENV NODEJS_HOME=${NODEJS_HOME} \
    NODEJS_VERSION=${NODEJS_VERSION} \
    NODEJS_PACKAGE=node-${NODEJS_VERSION}-${NODEJS_ARCH}.tar.xz \
    NODEJS_DOWNLOAD=https://nodejs.org/dist/${NODEJS_VERSION}/node-${NODEJS_VERSION}-${NODEJS_ARCH}.tar.xz \
    NODE_PATH=${NODEJS_HOME}/lib/node_modules \
    PATH=${PATH}:${NODEJS_HOME}/bin

RUN wget -q -O ${NODEJS_PACKAGE} ${NODEJS_DOWNLOAD} \
    && tar Jxf ${NODEJS_PACKAGE} \
    && rm ${NODEJS_PACKAGE} \
    && mv node-${NODEJS_VERSION}-${NODEJS_ARCH} ${NODEJS_HOME} \
    && node --version


# Install Sonar Build Wrapper
ARG SONAR_BUILD_WRAPPER_HOME=/opt/sonar-build-wrapper
ARG SONAR_BUILD_WRAPPER_ARCH=linux

ENV SONAR_BUILD_WRAPPER=build-wrapper-${SONAR_BUILD_WRAPPER_ARCH}-x86-64 \
    SONAR_BUILD_WRAPPER_PACKAGE=build-wrapper-${SONAR_BUILD_WRAPPER_ARCH}-x86 \
    SONAR_BUILD_WRAPPER_ZIP=build-wrapper-${SONAR_BUILD_WRAPPER_ARCH}-x86-64.zip \
    SONAR_BUILD_WRAPPER_HOME=${SONAR_BUILD_WRAPPER_HOME} \
    SONAR_BUILD_WRAPPER_DOWNLOAD=https://sonarcloud.io/static/cpp/build-wrapper-${SONAR_BUILD_WRAPPER_ARCH}-x86.zip \
    PATH=${PATH}:${SONAR_BUILD_WRAPPER_HOME}

RUN wget -q -O ${SONAR_BUILD_WRAPPER_ZIP} ${SONAR_BUILD_WRAPPER_DOWNLOAD} \
    && unzip -q -d ${SONAR_BUILD_WRAPPER_HOME} ${SONAR_BUILD_WRAPPER_ZIP} \
    && rm ${SONAR_BUILD_WRAPPER_ZIP} \
    && mv ${SONAR_BUILD_WRAPPER_HOME}/${SONAR_BUILD_WRAPPER_PACKAGE}/* ${SONAR_BUILD_WRAPPER_HOME} \
    && rm -rf ${SONAR_BUILD_WRAPPER_HOME}/${SONAR_BUILD_WRAPPER_PACKAGE} \
    && chmod +x ${SONAR_BUILD_WRAPPER_HOME}/${SONAR_BUILD_WRAPPER} \
    && ( \
        [ -e ${SONAR_BUILD_WRAPPER_HOME}/libinterceptor-haswell.so ] \
        || ln -sT ${SONAR_BUILD_WRAPPER_HOME}/libinterceptor-x86_64.so ${SONAR_BUILD_WRAPPER_HOME}/libinterceptor-haswell.so \
    ) \
    && ${SONAR_BUILD_WRAPPER} --out-dir ./tmp echo \
    && rm -rf tmp


# Original: https://github.com/SonarSource/sonar-scanner-cli-docker
# Original license: GNU Lesser General Public License v3.0
# Install Sonar Scanner
ARG SONAR_SCANNER_HOME=/opt/sonar-scanner
ARG SONAR_SCANNER_VERSION=4.3.0.2102
ARG SONAR_SCANNER_ARCH=linux
ARG SONAR_SCANNER_UID=1000
ARG SONAR_SCANNER_GID=1000
ENV SONAR_SCANNER_HOME=${SONAR_SCANNER_HOME} \
    SONAR_SCANNER_VERSION=${SONAR_SCANNER_VERSION} \
    SONAR_SCANNER_PACKAGE=sonar-scanner-cli-${SONAR_SCANNER_VERSION}-${SONAR_SCANNER_ARCH}.zip \
    SONAR_SCANNER_DOWNLOAD=https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}-${SONAR_SCANNER_ARCH}.zip \
    PATH=${PATH}:${SONAR_SCANNER_HOME}/bin

RUN groupadd --gid ${SONAR_SCANNER_GID} scanner-cli \
    && useradd --uid ${SONAR_SCANNER_UID} --gid scanner-cli --shell /bin/bash --create-home scanner-cli

RUN wget -q -O ${SONAR_SCANNER_PACKAGE} ${SONAR_SCANNER_DOWNLOAD} \
    && unzip -q -d ${SONAR_SCANNER_HOME} ${SONAR_SCANNER_PACKAGE} \
    && rm ${SONAR_SCANNER_PACKAGE} \
    && mv ${SONAR_SCANNER_HOME}/sonar-scanner-${SONAR_SCANNER_VERSION}-${SONAR_SCANNER_ARCH}/* ${SONAR_SCANNER_HOME} \
    && sonar-scanner --version

RUN npm install -g typescript@3.6.3 \
    && node -e "require('typescript')"

USER scanner-cli
RUN mkdir -p ~/.sonar/cache
