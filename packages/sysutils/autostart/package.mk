# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2020-present Fewtarius

PKG_NAME="autostart"
PKG_VERSION="$(date +%Y%m%d)"
PKG_ARCH="any"
PKG_LICENSE="apache2"
PKG_SITE=""
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="Autostart is a systemd helper that starts/configures device specific services and parameters."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp ${PKG_DIR}/sources/autostart ${INSTALL}/usr/bin
  mkdir -p ${INSTALL}/usr/lib/autostart/common
  mkdir -p ${INSTALL}/usr/lib/autostart/daemons
  cp ${PKG_DIR}/sources/common/* ${INSTALL}/usr/lib/autostart/common
  cp ${PKG_DIR}/sources/daemons/* ${INSTALL}/usr/lib/autostart/daemons
  mkdir -p ${INSTALL}/usr/lib/autostart/quirks
  cp -r ${PKG_DIR}/sources/quirks/* ${INSTALL}/usr/lib/autostart/quirks
  chmod -R 0755 ${INSTALL}/usr/lib/autostart ${INSTALL}/usr/bin/autostart
}
