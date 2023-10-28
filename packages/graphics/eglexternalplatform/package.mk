# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="eglexternalplatform"
PKG_VERSION="1.1"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/NVIDIA/${PKG_NAME}"
PKG_URL=${PKG_SITE}/archive/refs/tags/${PKG_VERSION}.tar.gz
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Wayland EGL External Platform library."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/{include,lib/pkgconfig}
  cp -rf ${PKG_BUILD}/interface/* ${SYSROOT_PREFIX}/usr/include
  cp -rf ${PKG_BUILD}/eglexternalplatform.pc ${SYSROOT_PREFIX}/usr/lib/pkgconfig
}
