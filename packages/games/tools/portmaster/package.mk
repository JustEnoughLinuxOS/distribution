# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present Fewtarius (https://github.com/fewtarius)
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="portmaster"
PKG_VERSION=""
PKG_ARCH="aarch64"
PKG_URL="https://github.com/christianhaitian/PortMaster/raw/main/PortMaster.zip"
PKG_PRIORITY="optional"
PKG_SECTION="tools"
PKG_SHORTDESC="A simple tool that allows you to download various game ports that are available for Jelos"
PKG_TOOLCHAIN="manual"

pre_unpack() {
  unzip sources/portmaster/portmaster-.zip -d ${PKG_BUILD}
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/
  cp -r ${PKG_BUILD}/PortMaster ${INSTALL}/usr/share/
  chmod 0755 $INSTALL/usr/share/PortMaster

  mkdir -p ${INSTALL}/usr/lib/autostart/common
  cp ${PKG_DIR}/sources/autostart/common/* ${INSTALL}/usr/lib/autostart/common
}
