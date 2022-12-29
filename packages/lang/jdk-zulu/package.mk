# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Peter Vicman (peter.vicman@gmail.com)
# Copyright (C) 2022-present Fewtarius

PKG_NAME="jdk-zulu"
PKG_VERSION="18.32.13-ca-jdk18.0.2.1"
PKG_LICENSE="GPLv2"
PKG_SITE="https://www.azul.com/products/zulu-enterprise/"

case ${TARGET_ARCH} in
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
  rm -f ${PKG_BUILD}/src.zip
}
