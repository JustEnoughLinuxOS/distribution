# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright (C) 2022-present travis134

PKG_NAME="wolfscan"
PKG_VERSION="a1348e1a48a9865e9a6b2e63ec515bbe3ab82167"
PKG_ARCH="any"
PKG_SITE="https://github.com/travis134/wolfscan"
PKG_URL="${PKG_SITE}.git"
PKG_PRIORITY="optional"
PKG_SECTION="tools"
PKG_SHORTDESC="Creates .ecwolf files based on user selection of WAD and PK3 files."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share
  cp -r ${PKG_BUILD}/wolfscan ${INSTALL}/usr/share
  cp "${PKG_BUILD}/_Scan Wolfenstein 3D Games.sh" ${INSTALL}/usr/share/wolfscan
  chmod 0755 ${INSTALL}/usr/share/wolfscan "${INSTALL}/usr/share/wolfscan/_Scan Wolfenstein 3D Games.sh"

  mkdir -p ${INSTALL}/usr/lib/autostart/common
  cp ${PKG_DIR}/sources/autostart/common/* ${INSTALL}/usr/lib/autostart/common
}
