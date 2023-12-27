# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libidn2"
PKG_VERSION="2.3.4"
PKG_LICENSE="LGPL3"
PKG_SITE="https://www.gnu.org/software/libidn/"
PKG_URL="http://ftp.gnu.org/gnu/libidn/libidn2-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Free software implementation of IDNA2008, Punycode and TR46."

PKG_CONFIGURE_OPTS_TARGET="--disable-doc \
                           --enable-shared \
                           --disable-static"

post_makeinstall_target() {
  safe_remove ${INSTALL}/usr/bin
}
