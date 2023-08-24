# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2023-present Fewtarius

PKG_NAME="libtracefs"
PKG_VERSION="1.7.0"
PKG_LICENSE="GPL"
PKG_SITE="https://git.kernel.org/pub/scm/libs/libtrace/${PKG_NAME}.git/log/"
PKG_URL="https://git.kernel.org/pub/scm/libs/libtrace/${PKG_NAME}.git/snapshot/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="ccache:host libtraceevent:host"
PKG_DEPENDS_TARGET="toolchain libtraceevent"
PKG_LONGDESC="Provides APIs to access kernel trace file system."
PKG_BUILD_FLAGS="+pic"

makeinstall_host() {
  mkdir -p ${TOOLCHAIN}/lib
  cp src/${PKG_NAME}.a ${TOOLCHAIN}/lib

  mkdir -p ${TOOLCHAIN}/include
  cp ${PKG_BUILD}/include/* ${TOOLCHAIN}/include

  mkdir -p ${TOOLCHAIN}/lib/pkgconfig
  cp meson-private/${PKG_NAME}.pc ${TOOLCHAIN}/lib/pkgconfig
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib
  cp src/${PKG_NAME}.a ${SYSROOT_PREFIX}/usr/lib

  mkdir -p ${SYSROOT_PREFIX}/usr/include
  cp ${PKG_BUILD}/include/* ${SYSROOT_PREFIX}/usr/include

  mkdir -p ${SYSROOT_PREFIX}/usr/lib/pkgconfig
  cp meson-private/${PKG_NAME}.pc ${SYSROOT_PREFIX}/usr/lib/pkgconfig
}
