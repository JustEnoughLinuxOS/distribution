# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present Fewtarius

PKG_NAME="pcsx2sa"
PKG_VERSION="v1.7.4097"
PKG_ARCH="x86_64"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/pcsx2/pcsx2"
PKG_URL="${PKG_SITE}/releases/download/${PKG_VERSION}/pcsx2-${PKG_VERSION}-linux-AppImage-64bit-Qt.AppImage"
PKG_LONGDESC="PS2 Emulator appimage"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  # Redefine strip or the AppImage will be stripped rendering it unusable.
  export STRIP=true
  mkdir -p ${INSTALL}/usr/bin
  cp ${PKG_BUILD}/${PKG_NAME}-${PKG_VERSION}.AppImage ${INSTALL}/usr/bin/${PKG_NAME}
  cp -rf ${PKG_DIR}/sources/start_pcsx2.sh ${INSTALL}/usr/bin
  sed -e "s/@APPIMAGE@/${PKG_NAME}/g" -i ${INSTALL}/usr/bin/start_pcsx2.sh
  chmod 755 ${INSTALL}/usr/bin/*
  mkdir -p ${INSTALL}/usr/config
  cp -rf ${PKG_DIR}/config/PCSX2 ${INSTALL}/usr/config
}
