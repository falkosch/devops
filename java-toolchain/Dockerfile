FROM maven:3.6.3-jdk-14

LABEL maintainer="falko.schwabe@googlemail.com"
LABEL version="1.0.0"
LABEL description="Provides an extended toolchain for maven builds."

RUN yum update -y \
    && yum install -y \
        ca-certificates \
        git \
        wget \
        unzip \
        tar \
        xz-utils \
        pylint \
    && yum clean all \
    && rm -rf /var/cache/yum


# Original: https://github.com/kkopper/oraclejdk-gradle
# Original license: MIT License
# Install Gradle
ARG GRADLE_HOME=/opt/gradle
ARG GRADLE_VERSION=6.2.2

ENV GRADLE_HOME=${GRADLE_HOME} \
    GRADLE_VERSION=${GRADLE_VERSION} \
    GRADLE_PACKAGE=gradle-${GRADLE_VERSION}-bin.zip \
    GRADLE_DOWNLOAD=https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip \
    PATH=${PATH}:${GRADLE_HOME}/gradle-${GRADLE_VERSION}/bin

RUN wget -q -O ${GRADLE_PACKAGE} ${GRADLE_DOWNLOAD} \
    && mkdir -p ${GRADLE_HOME} \
    && unzip -q -d ${GRADLE_HOME} ${GRADLE_PACKAGE} \
    && rm ${GRADLE_PACKAGE} \
    && gradle -v


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
