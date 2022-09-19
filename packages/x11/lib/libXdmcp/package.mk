# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="libXdmcp"
PKG_VERSION="1.1.3"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_URL="http://xorg.freedesktop.org/archive/individual/lib/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain util-macros libX11 libXext"
PKG_LONGDESC="libXdmcp - X Display Manager Control Protocol library"
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --enable-shared --enable-malloc0returnsnull"

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/
  cp $PKG_BUILD/.$TARGET_NAME/.libs/libXdmcp.so* $INSTALL/usr/lib/
}
