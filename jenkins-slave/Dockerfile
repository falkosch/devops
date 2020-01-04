# Provides an image with docker CLI installed that connects to the host docker
# engine to spawn container via e.g. a build node of the CI

# Configuration required in jenkins:
# * Add a new "static agent" via "Manage Jenkins" / "Manage Nodes" and set the following options:
# ** name: something informal, e.g. "jenkins-slave"
# ** # of executors: <count of CPU cores assigned for a container>
# ** remote directory: "/home/jenkins/agent"
# ** labels: according to the system specs of the container, e.g. "docker linux"
# ** usage: "Only build jobs with label expressions matching this node"
# ** launch method: "Launch agent via execution of command on the master"
# *** launch command: "docker run -i --rm -v /var/run/docker.sock:/var/run/docker.sock --name jenkins-slave jenkins-slave:latest"
# ** availability: "Bring this agent online when in demand, and take offline when idle"
# ** tool locations: checked
# *** list of tool locations: for windows host and linux container add an entry for the "Git" tool
# **** name: choose the Git tool, e.g. "(Git) git"
# **** home: "/usr/bin/git"

FROM jenkins/slave:latest-jdk11

USER root

# Add docker CLI to the image
# See https://docs.docker.com/install/linux/docker-ce/ubuntu/
RUN apt-get update \
  && apt-get install -y --no-install-recommends apt-transport-https ca-certificates curl gnupg2 software-properties-common \
  && curl -fsSL https://download.docker.com/linux/debian/gpg > ./gpg.key \
  && apt-key add ./gpg.key \
  && rm -f ./gpg.key \
  && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
  && apt-get update \
  && apt-get install -y docker-ce docker-ce-cli containerd.io \
  && rm -rf /var/lib/apt/lists/*

# Make docker.sock available for CLI connection to host and
# fix access permissions
RUN usermod -aG docker jenkins \
  && newgrp docker \
  && touch /var/run/docker.sock \
  && chown root:docker /var/run/docker.sock \
  && chmod 666 /var/run/docker.sock

USER jenkins

CMD ["/usr/local/openjdk-11/bin/java", "-jar", "/usr/share/jenkins/agent.jar"]
