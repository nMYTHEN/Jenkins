FROM jenkins/jenkins:lts-jdk11

USER root
# RUN commands

# prerequisites for docker
RUN apt-get update \
&& apt-get -y install \
apt-transport-https \
ca-certificates \
curl \
software-properties-common

# docker repos
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
&& echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable" >> /etc/apt/sources.list.d/additional-repositories.list \
&& echo "deb http://ftp-stud.hs-esslingen.de/ubuntu xenial main restricted universe multiverse" >> /etc/apt/sources.list.d/official-package-repositories.list \
&& apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 437D05B5 \
&& apt-get update

# docker
RUN apt-get -y install docker-ce

# docker-compose
RUN curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose \
&& chmod +x /usr/local/bin/docker-compose

RUN usermod -aG root jenkins
RUN usermod -aG docker jenkins
RUN service docker start
