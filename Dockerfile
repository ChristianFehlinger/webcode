ARG BASE_TAG=linuxserver/code-server:arm64v8-4.7.1
FROM $BASE_TAG

LABEL maintainer="Christian Fehlinger" \
      linux="ubuntu" \
      repository="" \
      application="code-server" \
      application_version=${CODE_SERVER_VERSION:?err}

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ENV TZ=Europe/Berlin

RUN apt-get update && \
    apt-get install -y \
        ca-certificates \
        curl \
        lsb-release \
        gpg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    update-ca-certificates --fresh 

# Install docker cli
RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    echo  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get install -y  docker-ce-cli containerd.io && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
