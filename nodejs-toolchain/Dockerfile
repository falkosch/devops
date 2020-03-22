FROM atlassianlabs/docker-node-jdk-chrome-firefox:2020-03-16

LABEL maintainer="falko.schwabe@googlemail.com"
LABEL version="1.0.0"
LABEL description="Provides an extended toolchain for nodejs builds."


# Upgrade environment
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get upgrade -y --no-install-recommends \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Install prerequisites
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
            gcc \
            g++ \
            make \
            apt-utils \
            rsync \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
