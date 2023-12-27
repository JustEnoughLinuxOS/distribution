# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="diffutils"
PKG_VERSION="3.9"
PKG_LICENSE="GPL"
PKG_SITE="http://www.gnu.org/software/diffutils/"
PKG_URL="http://ftp.gnu.org/gnu/diffutils/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A package of several programs related to finding differences between files."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--disable-nls \
        --without-libsigsegv-prefix \
        --without-libiconv-prefix \
        --without-libintl-prefix"

makeinstall_target() {
  : # nop
}
