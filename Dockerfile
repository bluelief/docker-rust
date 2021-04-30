FROM debian:testing-slim
ENV DEBIAN_FRONTEND noninteractive

# Metadata params
ARG USER
ARG GROUP

# User config
ARG USERNAME=rust
ARG GROUPNAME=rust
ARG HOMEDIR=/home/rust
ARG USERSHELL=/bin/bash

# Openssl version
ARG OPENSSL_VERSION=1.1.1k

# Setup apt package
RUN apt-get update -y \
    && apt-get upgrade -y \
    && yes '' | apt-get -y -o DPkg::options::="--force-confdef" \
      -o DPkg::options::="--force-confold" install -y \
    curl \
    ca-certificates \
    build-essential \
    musl-tools

# Setup openssl for musl rust
RUN mkdir -p /usr/local/musl/include \
    && cd /tmp \
    && curl -fLO "https://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz" \
    && tar xvzf "openssl-$OPENSSL_VERSION.tar.gz" && cd "openssl-$OPENSSL_VERSION" \
    && ./config -fPIE no-shared no-async --prefix=/usr/local/musl --openssldir=/usr/local/musl/ssl \
    && make -j$(nproc) \
    && make install \
    && rm -r /tmp/*

# Setup Timezone and locale
ENV TZ='Asia/Tokyo'
RUN apt-get install -y locales \
    && localedef -i ja_JP -c -f UTF-8 -A /usr/share/locale/locale.alias ja_JP.UTF-8
ENV LANG ja_JP.utf8

# Setup rust user
RUN addgroup --gid $GROUP $GROUPNAME && \
    adduser --home $HOMEDIR --shell $USERSHELL --uid $USER --disabled-password --disabled-login --gid $GROUP $USERNAME

USER rust:rust
SHELL ["/bin/bash", "-c"]

# Setup rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path --default-toolchain nightly \
    && source $HOME/.cargo/env \
    && echo '$HOME/.cargo/bin' >> $HOME/.bashrc \
    && rustup target add x86_64-unknown-linux-musl \
    && rustup install stable \
    && rustup component add rustfmt --toolchain stable
