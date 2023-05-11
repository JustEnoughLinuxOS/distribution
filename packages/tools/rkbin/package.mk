# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2023-present BrooksyTech

PKG_NAME="rkbin"
PKG_ARCH="arm aarch64"
PKG_LICENSE="nonfree"
PKG_SITE="https://github.com/JustEnoughLinuxOS/rkbin"
PKG_LONGDESC="rkbin: Rockchip Firmware and Tool Binaries"
PKG_TOOLCHAIN="manual"
PKG_PATCH_DIRS+="${DEVICE}*"

case ${DEVICE} in
  RK3326)
    PKG_VERSION="7f77e406fd1644967301bafb6bec71cf3c6cbb05"
    PKG_URL="${PKG_SITE}.git"
  ;;
  *)
    PKG_VERSION="9840e87723eef7c41235b89af8c049c1bcd3d133"
    PKG_URL="${PKG_SITE}.git"
  ;;
esac
