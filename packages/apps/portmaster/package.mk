# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="portmaster"
PKG_VERSION="7a4cddfdfc2fbbe631b53c8e4c418186fadc939f"
PKG_SITE="https://github.com/christianhaitian/PortMaster"
PKG_LICENSE="MIT"
PKG_ARCH="arm aarch64"
PKG_DEPENDS_TARGET="toolchain gptokeyb gamecontrollerdb wget"
PKG_TOOLCHAIN="manual"
PKG_LONGDESC="Portmaster - a simple tool that allows you to download various game ports"

makeinstall_target() {
  export STRIP=true
  mkdir -p ${INSTALL}/usr/config/PortMaster
  tar -xvf ${PKG_DIR}/sources/${PKG_NAME}.tar.gz -C ${INSTALL}/usr/config/PortMaster

  case ${DEVICE} in
    S922X)
      mkdir -p ${INSTALL}/usr/lib/egl
      tar -xvf ${PKG_DIR}/sources/libegl.tar.gz -C ${INSTALL}/usr/lib/egl
      cp -rf ${PKG_DIR}/sources/${DEVICE}/PortMaster.sh ${INSTALL}/usr/config/PortMaster
      chmod +x ${INSTALL}/usr/config/PortMaster/PortMaster.sh
    ;;
    *)
      cp -rf ${PKG_DIR}/sources/PortMaster.sh ${INSTALL}/usr/config/PortMaster
      chmod +x ${INSTALL}/usr/config/PortMaster/PortMaster.sh
    ;;
  esac

  mkdir -p ${INSTALL}/usr/bin
  cp -rf ${PKG_DIR}/scripts/* ${INSTALL}/usr/bin
  chmod +x ${INSTALL}/usr/bin/start_portmaster.sh
}
