# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="jelosaddons"
PKG_VERSION="56a4ada71dcd0d0cf1c6ba5c2058449f4ae4fcb2"
PKG_ARCH="any"
PKG_SITE="https://github.com/brooksytech/JelosAddOns"
PKG_URL="${PKG_SITE}/raw/${PKG_VERSION}/JelosAddOns.zip"
PKG_PRIORITY="optional"
PKG_SECTION="tools"
PKG_SHORTDESC="Additonal game ports and add ons not included with default install"
PKG_TOOLCHAIN="manual"

pre_unpack() {
  unzip sources/jelosaddons/jelosaddons-${PKG_VERSION}.zip -d ${PKG_BUILD}
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/
  cp -r ${PKG_BUILD}/JelosAddOns ${INSTALL}/usr/share/
  chmod 0755 $INSTALL/usr/share/JelosAddOns

  mkdir -p ${INSTALL}/usr/lib/autostart/common
  cp ${PKG_DIR}/sources/autostart/common/* ${INSTALL}/usr/lib/autostart/common
}
