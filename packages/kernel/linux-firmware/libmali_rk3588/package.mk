# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="libmali_rk3588"
PKG_VERSION="1.0"
PKG_LICENSE="GPLv3"
PKG_ARCH="arm aarch64"
PKG_DEPENDS_TARGET="kernel-firmware"
PKG_TOOLCHAIN="manual"
PKG_LONGDESC="Mali blob needed for RK3588 gpu"

makeinstall_target() {
  mkdir -p ${INSTALL}/$(get_full_firmware_dir)
  cp -rf ${PKG_DIR}/firmware/* ${INSTALL}/$(get_full_firmware_dir)/
}
