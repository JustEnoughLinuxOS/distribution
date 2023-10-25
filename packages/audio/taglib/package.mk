# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="taglib"
PKG_VERSION="1.13.1"
PKG_LICENSE="LGPL"
PKG_SITE="http://taglib.github.com/"
PKG_URL="https://taglib.org/releases/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain cmake:host zlib"
PKG_LONGDESC="TagLib is a library for reading and editing the meta-data of several popular audio formats."

PKG_CMAKE_OPTS_TARGET="-DBUILD_SHARED_LIBS=OFF \
                       -DWITH_MP4=ON \
                       -DWITH_ASF=ON"

post_makeinstall_target() {
  rm -rf ${INSTALL}/usr/bin
  # pkgconf hack
  sed -e "s:\(['=\" ]\)/usr:\\1${SYSROOT_PREFIX}/usr:g" -i ${SYSROOT_PREFIX}/usr/bin/taglib-config
  sed -e "s:\([':\" ]\)-I/usr:\\1-I${SYSROOT_PREFIX}/usr:g" -i ${SYSROOT_PREFIX}/usr/lib/pkgconfig/taglib.pc
  sed -e "s:\([':\" ]\)-L/usr:\\1-L${SYSROOT_PREFIX}/usr:g" -i ${SYSROOT_PREFIX}/usr/lib/pkgconfig/taglib.pc
  sed -e "s:\([':\" ]\)-I/usr:\\1-I${SYSROOT_PREFIX}/usr:g" -i ${SYSROOT_PREFIX}/usr/lib/pkgconfig/taglib_c.pc
  sed -e "s:\([':\" ]\)-L/usr:\\1-L${SYSROOT_PREFIX}/usr:g" -i ${SYSROOT_PREFIX}/usr/lib/pkgconfig/taglib_c.pc
}
