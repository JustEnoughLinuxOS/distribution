# Copyright (C) 2021-present Fewtarius

PKG_NAME="device-switch"
PKG_VERSION=""
PKG_SHA256=""
PKG_ARCH="any"
PKG_LICENSE="mix"
PKG_DEPENDS_TARGET="toolchain"
PKG_SITE=""
PKG_URL=""
PKG_LONGDESC="Support script for switching 353P to 353V."
PKG_TOOLCHAIN="manual"

makeinstall_target() {

  mkdir -p ${INSTALL}/usr/bin
  cp ${PKG_DIR}/sources/scripts/device-switch ${INSTALL}/usr/bin
  chmod 0755 ${INSTALL}/usr/bin/*

  mkdir -p ${INSTALL}/usr/config
  cp ${PKG_DIR}/sources/config/* ${INSTALL}/usr/config
}
