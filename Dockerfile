FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    g++ \
    make \
    cmake \
    pkg-config \
    curl \
    git \
    ripgrep \
    tar \
    wget \
    unzip \
    tmux \
    zsh \
    libbz2-dev \
    libncursesw5-dev \
    libffi-dev \
    libreadline-dev \
    libsqlite3-dev \
    liblzma-dev \
    zlib1g-dev \
    libssl-dev \
    openssl \
    fd-find \
    jq \
    openjdk-17-jdk \
    python3-openssl

RUN curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh && rm get-docker.sh

WORKDIR /root

COPY . /opt/devenv/

ENTRYPOINT ["/opt/devenv/shell/setup.sh"]

CMD ["/bin/zsh"]
