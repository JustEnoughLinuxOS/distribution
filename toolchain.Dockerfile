FROM justenoughlinuxos/jelos-build:latest

ARG source_path
ARG target_path

RUN echo "Copying $source_path to $target_path"
COPY $source_path $target_path

ENV TOOLCHAIN_BIN="$target_path/bin"
ENV TOOLCHAIN_SYSROOT="$target_path/aarch64-libreelec-linux-gnueabi/sysroot"

ENV CC="$target_path/bin/aarch64-libreelec-linux-gnueabi-gcc"
ENV CXX="$target_path/bin/aarch64-libreelec-linux-gnueabi-g++"
ENV PATH="$TOOLCHAIN_BIN:$PATH"

RUN echo "Path is $PATH"
RUN echo "CC is $CC"
RUN echo "CXX is $CXX"

WORKDIR /work
USER docker
