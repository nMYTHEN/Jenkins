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

# RUN apt-get update -qq && apt-get install -qqy apt-transport-https ca-certificates curl gnupg2 software-properties-common
# RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
# RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
# RUN apt-get update  -qq && apt-get install docker-ce=17.12.1~ce-0~debian -y

# docker
RUN apt-get -y install docker-ce

# docker-compose
RUN curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose \
  && chmod +x /usr/local/bin/docker-compose

RUN curl -sSl https://get.docker.com/ | sh

RUN usermod -aG root jenkins
RUN usermod -aG docker jenkins
RUN service docker start


# #########################
# FROM jenkins/jenkins:lts
# USER root
# RUN apt-get update -qq && apt-get install -qqy apt-transport-https ca-certificates curl gnupg2 software-properties-common
# RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
# RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
# RUN apt-get update  -qq && apt-get install docker-ce=17.12.1~ce-0~debian -y
# RUN usermod -aG docker jenkins