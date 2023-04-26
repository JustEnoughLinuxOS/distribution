# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2023-present BrooksyTech

PKG_NAME="rkbin"
PKG_VERSION="9840e87723eef7c41235b89af8c049c1bcd3d133"
PKG_ARCH="arm aarch64"
PKG_LICENSE="nonfree"
PKG_SITE="https://github.com/JustEnoughLinuxOS/rkbin"
PKG_URL="${PKG_SITE}.git"
PKG_LONGDESC="rkbin: Rockchip Firmware and Tool Binaries"
PKG_TOOLCHAIN="manual"
PKG_PATCH_DIRS+="${DEVICE}*"
