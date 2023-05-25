# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="portmaster"
PKG_VERSION="e0dcefc4fc2df80821b167b1bb8f50dedac2f3c5"
PKG_LICENSE="MIT"
PKG_ARCH="arm aarch64"
PKG_DEPENDS_TARGET="toolchain gptokeyb gamecontrollerdb wget"
PKG_TOOLCHAIN="manual"
PKG_LONGDESC="Portmaster - a simple tool that allows you to download various game ports"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/config/PortMaster
  tar -xvf ${PKG_DIR}/sources/${PKG_NAME}.tar.gz -C ${INSTALL}/usr/config/PortMaster
  cp -rf ${PKG_DIR}/sources/PortMaster.sh ${INSTALL}/usr/config/PortMaster
  chmod +x ${INSTALL}/usr/config/PortMaster/PortMaster.sh

  mkdir -p ${INSTALL}/usr/bin
  cp -rf ${PKG_DIR}/scripts/* ${INSTALL}/usr/bin
  chmod +x ${INSTALL}/usr/bin/start_portmaster.sh
}
