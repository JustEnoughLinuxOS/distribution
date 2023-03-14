# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2023-present BrooksyTech

PKG_NAME="rkbin"
PKG_VERSION="d6aad64d4874b416f25669748a9ae5592642a453"
PKG_ARCH="arm aarch64"
PKG_LICENSE="nonfree"
PKG_SITE="https://github.com/radxa/rkbin"
PKG_URL="${PKG_SITE}.git"
PKG_LONGDESC="rkbin: Rockchip Firmware and Tool Binaries"
PKG_TOOLCHAIN="manual"
PKG_PATCH_DIRS+="${DEVICE}"
