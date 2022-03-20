# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="jelosaddons"
PKG_VERSION=""
PKG_ARCH="any"
PKG_URL="https://github.com/brooksytech/JelosAddOns/raw/main/JelosAddOns.zip"
PKG_PRIORITY="optional"
PKG_SECTION="tools"
PKG_SHORTDESC="Additonal game ports and add ons not included with PortMaster"
PKG_TOOLCHAIN="manual"

pre_unpack() {
  unzip sources/jelosaddons/jelosaddons-.zip -d ${PKG_BUILD}
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/
  cp -r ${PKG_BUILD}/JelosAddOns ${INSTALL}/usr/share/
  chmod 0755 $INSTALL/usr/share/JelosAddOns

  mkdir -p ${INSTALL}/usr/lib/autostart/common
  cp ${PKG_DIR}/sources/autostart/common/* ${INSTALL}/usr/lib/autostart/common
}
