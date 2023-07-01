FROM ubuntu:22.04

RUN dpkg --add-architecture i386

RUN apt update  \
    && DEBIAN_FRONTEND=noninteractive \
      apt install -y \
      git lzop build-essential gcc bc libncurses5-dev libc6-i386 lib32stdc++6 zlib1g:i386 wget curl \
      && apt autoremove --purge -y \
      && apt clean -y \
      && rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-password --gecos '' docker

RUN mkdir -p /work && chown docker /work

RUN mkdir -p /opt/toolchains

RUN wget -L https://releases.linaro.org/components/toolchain/binaries/7.4-2019.02/aarch64-linux-gnu/gcc-linaro-7.4.1-2019.02-x86_64_aarch64-linux-gnu.tar.xz
RUN wget -L https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
RUN wget -L https://releases.linaro.org/archive/14.04/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2014.04_linux.tar.xz

RUN tar -Jxvf gcc-linaro-7.4.1-2019.02-x86_64_aarch64-linux-gnu.tar.xz -C /opt/toolchains/
RUN tar -xvf gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz -C /opt/toolchains/
RUN tar -xvf gcc-linaro-arm-none-eabi-4.8-2014.04_linux.tar.xz -C /opt/toolchains/

RUN rm -f gcc-linaro-7.4.1-2019.02-x86_64_aarch64-linux-gnu.tar.xz gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz gcc-linaro-arm-none-eabi-4.8-2014.04_linux.tar.xz

WORKDIR /work
USER docker
