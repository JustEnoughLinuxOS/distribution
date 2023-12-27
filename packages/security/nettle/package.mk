# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="nettle"
PKG_VERSION="3.9.1"
PKG_LICENSE="GPL2"
PKG_SITE="http://www.lysator.liu.se/~nisse/nettle"
PKG_URL="http://ftp.gnu.org/gnu/nettle/nettle-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="gmp:host openssl:host"
PKG_DEPENDS_TARGET="toolchain gmp openssl"
PKG_LONGDESC="A low-level cryptographic library."

PKG_CONFIGURE_OPTS_HOST="--disable-documentation"

PKG_CONFIGURE_OPTS_TARGET="${PKG_CONFIGURE_OPTS_HOST}"

if target_has_feature neon; then
  PKG_CONFIGURE_OPTS_TARGET+=" --enable-arm-neon"
fi

post_makeinstall_target() {
  rm -rf ${INSTALL}/usr/bin
}
