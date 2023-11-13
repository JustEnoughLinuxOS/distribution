# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="jq"
PKG_VERSION="1.7"
PKG_LICENSE="MIT"
PKG_SITE="http://stedolan.github.io/jq/"
PKG_URL="https://github.com/stedolan/jq/releases/download/${PKG_NAME}-${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain oniguruma"
PKG_LONGDESC="A like sed for JSON data."

PKG_CONFIGURE_OPTS_TARGET="--disable-shared \
                           --enable-static \
                           --disable-docs \
                           --disable-maintainer-mode \
                           --disable-valgrind"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp jq ${INSTALL}/usr/bin/
}

