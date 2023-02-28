ARG BASE_TAG=linuxserver/code-server:arm64v8-4.10.0

FROM $BASE_TAG

ARG CODE_SERVER_VERSION
ARG CODE_SERVER_ARCHITECTURE

LABEL maintainer="Christian Fehlinger" \
      linux="ubuntu" \
      repository="https://github.com/ChristianFehlinger/webcode" \
      registry="https://hub.docker.com/repository/docker/christianfehlinger/code" \
      application="code-server" \
      application_version=${CODE_SERVER_VERSION} \
      application_arch=${CODE_SERVER_ARCHITECTURE}

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ENV TZ=Europe/Berlin

RUN apt-get update -qq && \
    apt-get install -qy \
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
    apt-get install -y  docker-ce-cli && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -fsSL https://github.com/docker/compose/releases/download/v2.11.2/docker-compose-linux-aarch64 -o /usr/bin/docker-compose && \
    chmod +x  /usr/bin/docker-compose 
