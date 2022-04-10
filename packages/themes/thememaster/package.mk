# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present Fewtarius (https://github.com/fewtarius)
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="thememaster"
PKG_VERSION="896a413"
PKG_ARCH="any"
PKG_SITE="https://github.com/JohnIrvine1433/ThemeMaster"
PKG_URL="${PKG_SITE}.git"
PKG_PRIORITY="optional"
PKG_SECTION="theme"
PKG_SHORTDESC="A simple tool that allows you to download various themes."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/ThemeMaster
  cp -r ${PKG_BUILD}/* ${INSTALL}/usr/share/ThemeMaster
  chmod 0755 ${INSTALL}/usr/share/ThemeMaster ${INSTALL}/usr/share/ThemeMaster/ThemeMaster.sh

  mkdir -p ${INSTALL}/usr/lib/autostart/common
  cp ${PKG_DIR}/sources/autostart/common/* ${INSTALL}/usr/lib/autostart/common
}
