# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libXtst"
PKG_VERSION="14a44d0e3e6c3d9e757e2fdd143587efe532f1e9"
PKG_LICENSE="OSS"
PKG_SITE="https://gitlab.freedesktop.org/xorg/lib/libxtst"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain util-macros libXext libXi libX11"
PKG_LONGDESC="The Xtst Library"
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared --with-gnu-ld --without-xmlto"

pre_configure_target() {
  CFLAGS="${CFLAGS} -fPIC"
}

post_configure_target() {
  libtool_remove_rpath libtool
}
