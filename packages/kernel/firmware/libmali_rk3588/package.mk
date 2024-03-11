# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="libmali_rk3588"
PKG_VERSION="1.0"
PKG_LICENSE="GPLv3"
PKG_ARCH="arm aarch64"
PKG_DEPENDS_TARGET="kernel-firmware"
PKG_TOOLCHAIN="manual"
PKG_LONGDESC="Mali blob needed for RK3588 gpu"
PKG_ACE_FIRMWARE="https://github.com/JeffyCN/mirrors/raw/ca33693a03b2782edc237d1d3b786f94849bed7d/firmware/g610/mali_csffw.bin"

makeinstall_target() {
  mkdir -p ${INSTALL}/$(get_full_firmware_dir)
  case ${DEVICE} in
    RK3588*)
      # RK Linux 6.1 reequires libmali v18 for the moment
      curl -Lo ${INSTALL}/$(get_full_firmware_dir)/mali_csffw.bin ${PKG_ACE_FIRMWARE}
    ;;
    *)
      cp -rf ${PKG_DIR}/firmware/* ${INSTALL}/$(get_full_firmware_dir)/
    ;;
  esac
}
