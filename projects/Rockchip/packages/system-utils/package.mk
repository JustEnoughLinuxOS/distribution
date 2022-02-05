# Copyright (C) 2021-present Fewtarius

PKG_NAME="system-utils"
PKG_VERSION=""
PKG_SHA256=""
PKG_ARCH="any"
PKG_LICENSE="mix"
PKG_DEPENDS_TARGET="toolchain sleep"
PKG_SITE=""
PKG_URL=""
PKG_LONGDESC="Support scripts for Rockchip/Anbernic devices"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  cp fancontrol ${INSTALL}/usr/bin
  cp headphone_sense ${INSTALL}/usr/bin
  cp system_utils ${INSTALL}/usr/bin
  cp volume_sense ${INSTALL}/usr/bin
  cp battery ${INSTALL}/usr/bin
  chmod 0755 ${INSTALL}/usr/bin/*

  mkdir -p $INSTALL/usr/config
  cp fancontrol.conf $INSTALL/usr/config
}
