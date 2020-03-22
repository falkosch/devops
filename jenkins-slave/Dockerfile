FROM jenkins/slave:latest-jdk11

LABEL maintainer="falko.schwabe@googlemail.com"
LABEL version="1.0.0"
LABEL description="Provides an image with docker CLI installed that connects to the host docker engine to spawn container via e.g. a build node of the CI."

# Configuration required in jenkins:
# * Add a new "static agent" via "Manage Jenkins" / "Manage Nodes" and set the following options:
# ** name: something informal, e.g. "jenkins-slave"
# ** # of executors: <count of CPU cores assigned for a container>
# ** remote directory: "/home/jenkins/agent"
# ** labels: according to the system specs of the container, e.g. "docker linux"
# ** usage: "Only build jobs with label expressions matching this node"
# ** launch method: "Launch agent via execution of command on the master"
# *** launch command: "docker run -i --rm -v /var/run/docker.sock:/var/run/docker.sock --name jenkins-slave schwabe/jenkins-slave:latest"
# ** availability: "Bring this agent online when in demand, and take offline when idle"
# ** tool locations: checked
# *** list of tool locations: for windows host and linux container add an entry for the "Git" tool
# **** name: choose the Git tool, e.g. "(Git) git"
# **** home: "/usr/bin/git"

USER root


# Upgrade environment
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get upgrade -y --no-install-recommends \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Install prerequisites
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
            apt-utils \
            apt-transport-https \
            gnupg2 \
            software-properties-common \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Add docker CLI to the image
# See https://docs.docker.com/install/linux/docker-ce/debian/
RUN curl -fsSL https://download.docker.com/linux/debian/gpg > ./gpg.key \
    && apt-key add ./gpg.key \
    && rm -f ./gpg.key \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
            docker-ce \
            docker-ce-cli \
            containerd.io \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Put jenkins in the docker group so that it can access /var/run/docker.sock
RUN usermod -aG docker jenkins \
    && newgrp docker

# Setup an init script that
# fixes group ownership on "/var/run/docker.sock" volume and
# starts the jenkins-slave agent
# when image is started with "docker run".
RUN { \
      echo "#!/usr/bin/env bash"; \
      echo "chown root:docker /var/run/docker.sock"; \
      echo "su jenkins -c '/usr/local/openjdk-11/bin/java -jar /usr/share/jenkins/agent.jar'"; \
    } >> /root/init.sh \
    && chmod +x /root/init.sh

# Run the init script when the image is started
ENTRYPOINT exec /root/init.sh
