FROM ubuntu:jammy

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get dist-upgrade -y \
 && apt-get install -y locales sudo

RUN locale-gen en_US.UTF-8 \
 && update-locale LANG=en_US.UTF-8 LANGUAGE=en_US:en
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

RUN adduser --disabled-password --gecos '' docker \
 && adduser docker sudo \
 && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN apt-get install -y \
    bc default-jre file gawk gcc git golang-go gperf libjson-perl libncurses5-dev \
    libparse-yapp-perl libxml-parser-perl lzop make patchutils python-is-python3 \
    python3 unzip wget xfonts-utils xsltproc zip zstd

RUN mkdir -p /work && chown docker /work

WORKDIR /work
USER docker
