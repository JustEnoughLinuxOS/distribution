# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="drastic"
PKG_LICENSE="GPLv3"
PKG_ARCH="arm aarch64"
PKG_DEPENDS_TARGET="toolchain"
PKG_TOOLCHAIN="make"
PKG_LONGDESC="Install Drastic Launcher script, will dowload bin on first run"

make_target() {
  :
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp -rf ${PKG_DIR}/scripts/* ${INSTALL}/usr/bin

  chmod +x ${INSTALL}/usr/bin/start_drastic.sh
  mkdir -p ${INSTALL}/usr/config/drastic
  cp -rf ${PKG_DIR}/config/${DEVICE}/drastic.cfg ${INSTALL}/usr/config/drastic/drastic.cfg
}
