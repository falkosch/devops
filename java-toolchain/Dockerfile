FROM maven:3.6.3-jdk-13

LABEL maintainer="falko.schwabe@googlemail.com"
LABEL version="1.0.0"
LABEL description="Provides an extended toolchain for maven builds."

RUN yum install -y \
        ca-certificates \
        git \
        wget \
        unzip \
        tar \
        xz-utils \
        pylint \
    && rm -rf /var/cache/yum


# Original: https://github.com/kkopper/oraclejdk-gradle
# Original license: MIT License
# Install Gradle
ARG GRADLE_HOME=/opt/gradle
ARG GRADLE_VERSION=6.2.1
ENV GRADLE_HOME=${GRADLE_HOME} \
    GRADLE_VERSION=${GRADLE_VERSION} \
    PATH=${PATH}:${GRADLE_HOME}/gradle-${GRADLE_VERSION}/bin
RUN wget -q -O gradle-bin.zip https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip \
    && mkdir -p ${GRADLE_HOME} \
    && unzip -q -d ${GRADLE_HOME} gradle-bin.zip \
    && rm gradle-bin.zip \
    && gradle -v


# Install NodeJS
ARG NODEJS_HOME=/opt/nodejs
ARG NODEJS_VERSION=v13.9.0
ARG NODEJS_ARCH=linux-x64
ENV NODEJS_HOME=${NODEJS_HOME} \
    NODEJS_VERSION=${NODEJS_VERSION} \
    NODE_PATH=${NODEJS_HOME}/lib/node_modules \
    PATH=${PATH}:${NODEJS_HOME}/bin
RUN wget -q -O nodejs.tar.xz https://nodejs.org/dist/${NODEJS_VERSION}/node-${NODEJS_VERSION}-${NODEJS_ARCH}.tar.xz \
    && tar Jxf nodejs.tar.xz \
    && mv node-${NODEJS_VERSION}-${NODEJS_ARCH} ${NODEJS_HOME} \
    && rm nodejs.tar.xz \
    && node --version


# Original: https://github.com/SonarSource/sonar-scanner-cli-docker
# Original license: GNU Lesser General Public License v3.0
# Install Sonar Scanner
ARG SONAR_SCANNER_HOME=/opt/sonar-scanner
ARG SONAR_SCANNER_VERSION=4.3.0.2102
ARG SONAR_SCANNER_ARCH=linux
ARG UID=1000
ARG GID=1000
ENV SONAR_SCANNER_HOME=${SONAR_SCANNER_HOME} \
    SONAR_SCANNER_VERSION=${SONAR_SCANNER_VERSION} \
    PATH=${PATH}:${SONAR_SCANNER_HOME}/bin

RUN groupadd --gid ${GID} scanner-cli \
    && useradd --uid ${UID} --gid scanner-cli --shell /bin/bash --create-home scanner-cli

RUN wget -q -O sonar-scanner-cli.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}-${SONAR_SCANNER_ARCH}.zip \
    && unzip -q -d ${SONAR_SCANNER_HOME} sonar-scanner-cli.zip \
    && mv ${SONAR_SCANNER_HOME}/sonar-scanner-${SONAR_SCANNER_VERSION}-${SONAR_SCANNER_ARCH}/* ${SONAR_SCANNER_HOME} \
    && rm sonar-scanner-cli.zip \
    && sonar-scanner --version

RUN npm install -g typescript@3.6.3 \
    && node -e "require('typescript')"

USER scanner-cli
RUN mkdir -p ~/.sonar/cache
