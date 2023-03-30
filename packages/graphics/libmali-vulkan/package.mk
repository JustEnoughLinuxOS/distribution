# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="libmali-vulkan"
PKG_VERSION="1.0"
PKG_LICENSE="GPLv3"
PKG_ARCH="arm aarch64"
PKG_DEPENDS_TARGET="toolchain mesa vulkan-tools"
PKG_TOOLCHAIN="manual"
PKG_LONGDESC="Vulkan Mali drivers for s922x soc"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib
  mkdir -p ${INSTALL}/usr/share
  tar -xvf ${PKG_DIR}/sources/${PKG_NAME}.tar.gz -C ${INSTALL}/
}
