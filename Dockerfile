FROM ubuntu
RUN apt-get update && apt-get install -y sudo wget apt-transport-https ca-certificates curl gnupg2 software-properties-common tar git openssl gzip unzip zip
# Standard Encoding von ASCII auf UTF-8 stellen
ENV LANG C.UTF-8

## Install Node
RUN curl -sL https://deb.nodesource.com/setup_10.x > install.sh && chmod +x install.sh && ./install.sh && \
    apt-get install -y nodejs

# Neustes npm
RUN npm install -g npm@latest
RUN npm install -g github-release-cli

ARG GRADLE_VERSION=4.10.3
ARG JDK_VERSION=8
## Openjdk 
RUN apt install -y openjdk-${JDK_VERSION}-jdk-headless 
## Gradle
ENV GRADLE_HOME /opt/gradle
RUN wget --output-document=gradle.zip  https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip && \
    unzip gradle.zip && \
    rm gradle.zip && \
    mv "gradle-${GRADLE_VERSION}" "${GRADLE_HOME}/" && \
    ln --symbolic "${GRADLE_HOME}/bin/gradle" /usr/bin/gradle

RUN sudo apt-get update 

WORKDIR /
USER root
CMD /bin/bash