FROM jenkins/slave:latest-jdk11

# see https://docs.docker.com/install/linux/docker-ce/ubuntu/
USER root
RUN apt-get update \
  && apt-get install -y --no-install-recommends apt-transport-https ca-certificates curl gnupg2 software-properties-common \
  && curl -fsSL https://download.docker.com/linux/debian/gpg > ./gpg.key \
  && apt-key add ./gpg.key \
  && rm -f ./gpg.key \
  && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
  && apt-get update \
  && apt-get install -y docker-ce docker-ce-cli containerd.io \
  && rm -rf /var/lib/apt/lists/* \
  && usermod -aG docker jenkins \
  && newgrp docker \
  && sudo docker run hello-world

USER jenkins
VOLUME ["/var/run/docker.sock"]
RUN docker -v && docker run --rm hello-world
