# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="ryujinx-sa"
PKG_VERSION="1.1.667"
PKG_ARCH="x86_64"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/Ryujinx"
PKG_URL="${PKG_SITE}/release-channel-master/releases/download/${PKG_VERSION}/ryujinx-${PKG_VERSION}-linux_x64.tar.gz"
PKG_DEPENDS_TARGET="toolchain librsvg SDL2 openal-soft"
PKG_LONGDESC="Ryujinx - Nintendo Switch Emulator"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  export STRIP=true
  mkdir -p ${INSTALL}/usr/bin
  cp -rf ${PKG_DIR}/scripts/* ${INSTALL}/usr/bin

  chmod +x ${INSTALL}/usr/bin/start_ryujinx.sh

  mkdir -p ${INSTALL}/usr/config/Ryujinx
  cp -rf ${PKG_BUILD}/Ryujinx ${INSTALL}/usr/config/Ryujinx/
  cp -rf ${PKG_BUILD}/mime ${INSTALL}/usr/config/Ryujinx
  cp -rf ${PKG_BUILD}/LICENSE.txt ${INSTALL}/usr/config/Ryujinx
  cp -rf ${PKG_DIR}/config/* ${INSTALL}/usr/config/Ryujinx
}
