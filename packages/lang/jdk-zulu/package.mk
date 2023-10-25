# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Peter Vicman (peter.vicman@gmail.com)
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)
PKG_NAME="jdk-zulu"
PKG_VERSION="20.32.11-ca-jdk20.0.2"
PKG_LICENSE="GPLv2"
PKG_SITE="https://www.azul.com/products/zulu-enterprise/"

HOST_ARCH=$(uname -m)
case ${HOST_ARCH} in
  aarch64)
    ZULUARCH="aarch64"
  ;;
  x86_64)
    ZULUARCH="x64"
  ;;
esac

PKG_URL="https://cdn.azul.com/zulu/bin/zulu${PKG_VERSION}-linux_${ZULUARCH}.tar.gz"

PKG_LONGDESC="Zulu, the open Java(TM) platform from Azul Systems."
PKG_TOOLCHAIN="manual"

post_unpack() {
  rm -f ${PKG_BUILD}/src.zip ${SOURCES}/${PKG_NAME}/*
}
