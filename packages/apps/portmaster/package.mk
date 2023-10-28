# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present - The JELOS Project (https://github.com/JustEnoughLinuxOS)

PKG_NAME="portmaster"
PKG_VERSION="f8adbe08805d9fe9171cb2e3078f383631d1331d"
PKG_SITE="https://github.com/christianhaitian/PortMaster"
PKG_LICENSE="MIT"
PKG_ARCH="arm aarch64"
PKG_DEPENDS_TARGET="toolchain gptokeyb gamecontrollerdb wget oga_controls libegl"
PKG_TOOLCHAIN="manual"
PKG_LONGDESC="Portmaster - a simple tool that allows you to download various game ports"

makeinstall_target() {
  export STRIP=true
  mkdir -p ${INSTALL}/usr/config/PortMaster
  tar -xvf ${PKG_DIR}/sources/${PKG_NAME}.tar.gz -C ${INSTALL}/usr/config/PortMaster

  cp -rf ${PKG_DIR}/sources/PortMaster.sh ${INSTALL}/usr/config/PortMaster
  chmod +x ${INSTALL}/usr/config/PortMaster/PortMaster.sh

  mkdir -p ${INSTALL}/usr/bin
  cp -rf ${PKG_DIR}/scripts/* ${INSTALL}/usr/bin
  chmod +x ${INSTALL}/usr/bin/start_portmaster.sh

  sed -e "s/jelos.dialogrc/All_Black.dialogrc/g" \
      -i ${INSTALL}/usr/config/PortMaster/PortMaster.sh
  cp -rf ${PKG_DIR}/sources/All_Black.dialogrc ${INSTALL}/usr/config/PortMaster/colorscheme
}
