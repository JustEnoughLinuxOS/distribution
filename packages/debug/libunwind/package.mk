# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libunwind"
PKG_VERSION="1.6.2"
PKG_LICENSE="GPL"
PKG_SITE="http://www.nongnu.org/libunwind/"
PKG_URL="http://download.savannah.nongnu.org/releases/libunwind/libunwind-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="gcc:host"
PKG_LONGDESC="library to determine the call-chain of a program"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
			   --disable-shared"

makeinstall_target() {
  make DESTDIR=$SYSROOT_PREFIX install
}
