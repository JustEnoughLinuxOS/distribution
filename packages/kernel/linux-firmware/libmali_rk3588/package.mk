# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="libmali_rk3588"
PKG_LICENSE="GPLv3"
PKG_ARCH="arm aarch64"
PKG_DEPENDS_TARGET="kernel-firmware"
PKG_TOOLCHAIN="manual"
#PKG_TOOLCHAIN="make"
PKG_LONGDESC="Mali blob needed for RK3588 gpu"

#make_target() {
#  :
#}

makeinstall_target() {
  mkdir -p ${INSTALL}/$(get_full_firmware_dir)
  cp -rf ${PKG_DIR}/firmware/* ${INSTALL}/$(get_full_firmware_dir)/
}
