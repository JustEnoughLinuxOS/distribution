# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright (C) 2022-present travis134

PKG_NAME="doomscan"
PKG_VERSION="3bba0abe4dd13c7c77f6d5e355a8e70ee650720a"
PKG_ARCH="any"
PKG_SITE="https://github.com/travis134/doomscan"
PKG_URL="${PKG_SITE}.git"
PKG_PRIORITY="optional"
PKG_SECTION="tools"
PKG_SHORTDESC="Creates .doom files based on user selection of WAD and PK3 files."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share
  cp -r ${PKG_BUILD}/doomscan ${INSTALL}/usr/share
  cp "${PKG_BUILD}/_Scan Doom Games.sh" ${INSTALL}/usr/share/doomscan
  chmod 0755 ${INSTALL}/usr/share/doomscan "${INSTALL}/usr/share/doomscan/_Scan Doom Games.sh"

  mkdir -p ${INSTALL}/usr/lib/autostart/common
  cp ${PKG_DIR}/sources/autostart/common/* ${INSTALL}/usr/lib/autostart/common
}
