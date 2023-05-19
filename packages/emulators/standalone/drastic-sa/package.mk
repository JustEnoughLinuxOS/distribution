# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="drastic-sa"
PKG_VERSION="1.0"
PKG_LICENSE="Proprietary:DRASTIC.pdf"
PKG_ARCH="aarch64"
PKG_URL="https://github.com/brooksytech/JelosAddOns/raw/main/drastic.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Install Drastic Launcher script, will dowload bin on first run"
PKG_TOOLCHAIN="make"

make_target() {
  :
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin

  case ${DEVICE} in
    S922X*)
      cp -rf ${PKG_DIR}/scripts/S922X/start_drastic.sh ${INSTALL}/usr/bin
    ;;
    *)
      cp -rf ${PKG_DIR}/scripts/start_drastic.sh ${INSTALL}/usr/bin
    ;;
  esac

  chmod +x ${INSTALL}/usr/bin/start_drastic.sh

  mkdir -p ${INSTALL}/usr/config/drastic/config
  cp -rf ${PKG_BUILD}/drastic_aarch64/* ${INSTALL}/usr/config/drastic/
  cp -rf ${PKG_DIR}/config/${DEVICE}/* ${INSTALL}/usr/config/drastic/config/
}
