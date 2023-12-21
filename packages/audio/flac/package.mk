# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="flac"
PKG_VERSION="1.4.3"
PKG_LICENSE="GPLv2"
PKG_SITE="https://xiph.org/flac/"
PKG_URL="http://downloads.xiph.org/releases/flac/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain libogg"
PKG_LONGDESC="An Free Lossless Audio Codec."
PKG_BUILD_FLAGS="+speed"

pre_configure_target() {
  PKG_CMAKE_OPTS_TARGET="-DBUILD_SHARED_LIBS=ON \
                         -DWITH_STACK_PROTECTOR=OFF \
                         -DINSTALL_MANPAGES=OFF \
                         -DNDEBUG=OFF"
}

post_makeinstall_target() {
  rm -rf ${INSTALL}/usr/bin
}
