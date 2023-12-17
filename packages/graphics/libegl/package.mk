# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="libegl"
PKG_VERSION="1.0"
PKG_LICENSE="GPLv2"
PKG_ARCH="arm aarch64"
PKG_DEPENDS_TARGET="toolchain"
PKG_TOOLCHAIN="manual"
PKG_LONGDESC="Libraries needed to run OpenGL applications on devices that dont have native OpenGL support."

makeinstall_target() {
  export STRIP=true
  mkdir -p ${INSTALL}/usr/lib/egl
  tar -xvf ${PKG_DIR}/sources/libegl.tar.gz -C ${INSTALL}/usr/lib/egl
}
