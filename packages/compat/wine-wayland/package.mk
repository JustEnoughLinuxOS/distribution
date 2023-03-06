# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2023-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="wine-wayland"
PKG_VERSION="8.2.1"
PKG_LICENSE="free"
PKG_SITE="https://github.com/varmd/wine-wayland"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="wine wayland"
PKG_TOOLCHAIN="manual"

PKG_SITE_X32="${PKG_SITE}/releases/download/v${PKG_VERSION}/lib32-${PKG_NAME}-8.2-1-x86_64.pkg.tar.zst"
PKG_SITE_X64="${PKG_SITE}/releases/download/v${PKG_VERSION}/${PKG_NAME}-8.2-1-x86_64.pkg.tar.zst"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  mkdir -p ${INSTALL}/usr/config
  mkdir -p ${INSTALL}/usr/lib
  mkdir -p ${INSTALL}/usr/lib32

  #Download Wine Wayland x32 packages
  curl -Lo ${PKG_BUILD}/${PKG_NAME}_X32.tar.zst ${PKG_SITE_X32}
  unzstd ${PKG_BUILD}/${PKG_NAME}_X32.tar.zst
  tar -xvf ${PKG_BUILD}/${PKG_NAME}_X32.tar -C ${INSTALL}/


  #Download Wine Wayland x64 packages
  curl -Lo ${PKG_BUILD}/${PKG_NAME}_X64.tar.zst ${PKG_SITE_X64}
  unzstd ${PKG_BUILD}/${PKG_NAME}_X64.tar.zst
  tar -xvf ${PKG_BUILD}/${PKG_NAME}_X64.tar -C ${INSTALL}/
}
