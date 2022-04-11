# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="drastic"
PKG_VERSION=""
PKG_SHA256="173c272fa41b136f3be7266f730d1c89cfc2b60a40112d14f0fc8e033d33ee1b"
PKG_ARCH="any"
PKG_URL="https://github.com/brooksytech/JelosAddOns/raw/main/drastic.zip"
PKG_PRIORITY="optional"
PKG_SECTION="tools"
PKG_SHORTDESC="Optional NDS emulator, DraStic"
PKG_TOOLCHAIN="manual"

pre_unpack() {
  unzip sources/drastic/drastic-.zip -d ${PKG_BUILD}
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/
  cp -r ${PKG_BUILD}/drastic ${INSTALL}/usr/share/
  chmod 0755 $INSTALL/usr/share/drastic
  chmod +x ${INSTALL}/usr/share/drastic/install.sh
  chmod +x ${INSTALL}/usr/share/drastic/uninstall.sh
  
}
