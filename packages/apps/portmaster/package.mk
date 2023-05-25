# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="portmaster"
PKG_VERSION="b817dcd13c4486284874c13b2732d876a96e70b9"
PKG_SITE="https://github.com/christianhaitian/PortMaster"
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
  sed -e "s/jelos.dialogrc/All_Black.dialogrc/g" \
      -i ${INSTALL}/usr/config/PortMaster/PortMaster.sh
  cp -rf ${PKG_DIR}/sources/All_Black.dialogrc ${INSTALL}/usr/config/PortMaster/colorscheme

  mkdir -p ${INSTALL}/usr/bin
  cp -rf ${PKG_DIR}/scripts/* ${INSTALL}/usr/bin
  chmod +x ${INSTALL}/usr/bin/start_portmaster.sh
}
