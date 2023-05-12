# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2023-present Fewtarius

PKG_NAME="util-macros"
PKG_VERSION="1.20.0"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_URL="http://xorg.freedesktop.org/archive/individual/util/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="X.org autoconf utilities such as M4 macros."

pre_configure_target() {
  sed -i 's|^pkgconfigdir = .*|pkgconfigdir = /usr/lib/pkgconfig|' ${PKG_BUILD}/Makefile.am
  sed -i 's|^pkgconfigdir = .*|pkgconfigdir = /usr/lib/pkgconfig|' ${PKG_BUILD}/Makefile.in
}

post_makeinstall_target() {
  rm -rf ${INSTALL}/usr
}
