FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Etc/UTC \
    NODE_VERSION=22.11.0 \
    JHIPSTER_VERSION=8.11.0

RUN \
  # configure the "jhipster" user
  groupadd jhipster && \
  useradd jhipster -s /bin/bash -m -g jhipster -G sudo && \
  echo 'jhipster:jhipster' | chpasswd && \
  mkdir -p /home/jhipster/app

RUN \
  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
  apt-get update && \
  # install utilities required by the latest JHipster toolchain
  apt-get install -y \
    ca-certificates \
    curl \
    git \
    gnupg \
    openjdk-21-jdk-headless \
    software-properties-common \
    sudo \
    unzip \
    wget \
    xz-utils && \
  rm -rf /var/lib/apt/lists/*

RUN \
  # install Node.js LTS via official archive
  wget --no-check-certificate https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz -O /tmp/node.tar.xz && \
  tar -C /usr/local --strip-components 1 -xJf /tmp/node.tar.xz && \
  rm /tmp/node.tar.xz && \
  npm install -g npm && \
  npm install -g yo && \
  npm cache clean --force

RUN \
  # install the latest JHipster generator
  npm install -g generator-jhipster@${JHIPSTER_VERSION} && \
  # fix jhipster user permissions
  chown -R jhipster:jhipster \
    /home/jhipster \
    /usr/local/lib/node_modules && \
  # cleanup
  rm -rf \
    /home/jhipster/.cache/ \
    /tmp/* \
    /var/tmp/*

# expose the working directory
USER jhipster
ENV PATH $PATH:/usr/bin
WORKDIR "/home/jhipster/app"
VOLUME ["/home/jhipster/app"]
CMD jhipster