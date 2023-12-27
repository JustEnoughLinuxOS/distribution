# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="rkbin"
PKG_ARCH="arm aarch64"
PKG_LICENSE="nonfree"
PKG_SITE="https://github.com/JustEnoughLinuxOS/rkbin"
PKG_LONGDESC="rkbin: Rockchip Firmware and Tool Binaries"
PKG_TOOLCHAIN="manual"
PKG_PATCH_DIRS+="${DEVICE}*"

PKG_VERSION="5257e54cc6c15fef28c3b73bd95ca1b55cc8c8cd"
PKG_URL="${PKG_SITE}.git"
