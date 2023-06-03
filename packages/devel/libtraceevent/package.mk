# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2023-present Fewtarius

PKG_NAME="libtraceevent"
PKG_VERSION="1.7.2"
PKG_LICENSE="GPL"
PKG_SITE="https://git.kernel.org/pub/scm/libs/libtrace/${PKG_NAME}.git/log/"
PKG_URL="https://git.kernel.org/pub/scm/libs/libtrace/${PKG_NAME}.git/snapshot/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="ccache:host"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_LONGDESC="Provides APIs to access kernel tracepoint events."
PKG_BUILD_FLAGS="+pic"

makeinstall_host() {
  mkdir -p ${TOOLCHAIN}/lib
  cp lib/${PKG_NAME}.a ${TOOLCHAIN}/lib

  mkdir -p ${TOOLCHAIN}/include
  cp include/traceevent/* ${TOOLCHAIN}/include

  mkdir -p ${TOOLCHAIN}/lib/pkgconfig
  cp ${PKG_NAME}.pc ${TOOLCHAIN}/lib/pkgconfig
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib
  cp lib/${PKG_NAME}.a ${SYSROOT_PREFIX}/usr/lib

  mkdir -p ${SYSROOT_PREFIX}/usr/include
  cp include/traceevent/* ${SYSROOT_PREFIX}/usr/include

  mkdir -p ${SYSROOT_PREFIX}/usr/lib/pkgconfig
  cp ${PKG_NAME}.pc ${SYSROOT_PREFIX}/usr/lib/pkgconfig
}
