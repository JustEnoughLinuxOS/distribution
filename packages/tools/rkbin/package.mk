# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="rkbin"

if [[ "${DEVICE}" =~ RG351 ]]; then
	PKG_VERSION="0bb1c512492386a72a3a0b5a0e18e49c636577b9"
else
	PKG_VERSION="7d631e0d5b2d373b54d4533580d08fb9bd2eaad4"
fi

PKG_ARCH="arm aarch64"
PKG_LICENSE="nonfree"
PKG_SITE="https://github.com/rockchip-linux/rkbin"
PKG_URL="https://github.com/rockchip-linux/rkbin/archive/$PKG_VERSION.tar.gz"
PKG_LONGDESC="rkbin: Rockchip Firmware and Tool Binaries"
PKG_TOOLCHAIN="manual"
