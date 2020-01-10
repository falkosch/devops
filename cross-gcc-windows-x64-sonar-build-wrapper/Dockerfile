FROM dockcross/windows-static-x64:20191223-c07e40f

LABEL maintainer="falko.schwabe@googlemail.com"
LABEL version="1.0.0"
LABEL description="Adds the sonar build wrapper for cpp to 'dockcross windows-x64 static' as base image for analyzing C/C++ projects."

ENV BUILD_WRAPPER_PACKAGE="build-wrapper-linux-x86"
ENV BUILD_WRAPPER_ZIP="${BUILD_WRAPPER_PACKAGE}.zip"
ENV BUILD_WRAPPER="build-wrapper-linux-x86-64"

ENV SONAR_QUBE_URL="https://sonarcloud.io/static/cpp/${BUILD_WRAPPER_ZIP}"

RUN cd /tmp \
  && rm -rf ./* \
  && wget -q ${SONAR_QUBE_URL} \
  && unzip ${BUILD_WRAPPER_ZIP} \
  && rm ${BUILD_WRAPPER_ZIP} \
  && mv -t /usr/local *

RUN cd /usr/local/${BUILD_WRAPPER_PACKAGE} \
  && chmod +x ${BUILD_WRAPPER} \
  && ln -sT libinterceptor-x86_64.so libinterceptor-haswell.so

RUN cd /usr/local/bin \
  && ln -sT /usr/local/${BUILD_WRAPPER_PACKAGE}/${BUILD_WRAPPER} ${BUILD_WRAPPER}
