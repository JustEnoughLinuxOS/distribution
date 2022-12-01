# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="valgrind"
PKG_VERSION="3.20.0"
PKG_LICENSE="GPL"
PKG_SITE="http://valgrind.org/"
PKG_URL="https://sourceware.org/pub/valgrind/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A tool to help find memory-management problems in programs"

case ${TARGET_ARCH} in
  arm)
    PKG_CONFIGURE_OPTS_TARGET="--enable-only32bit"
  ;;
  *)
    PKG_CONFIGURE_OPTS_TARGET="--enable-only64bit"
  ;;
esac
