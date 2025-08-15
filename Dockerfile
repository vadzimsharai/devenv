FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt-get update && apt-get install -y \
    build-essential \
    zsh \ 
    git \ 
    sudo \
    gcc \
    g++ \
    make \
    cmake \
    pkg-config \
    curl \
    ripgrep \
    tar \
    wget \
    unzip \
    tmux \
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
    
RUN useradd -m -s /bin/zsh devenv && \
    echo "devenv:devenv" | chpasswd && \
    echo "devenv ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    usermod -aG docker devenv

RUN mkdir -p /opt/devenv/shell && touch /opt/devenv/shell/setup.sh

WORKDIR /home/devenv

USER devenv

CMD ["/bin/zsh"]
