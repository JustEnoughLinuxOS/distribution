# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team CoreELEC (https://coreelec.org)

PKG_NAME="rtk_hciattach"
PKG_VERSION="a03e128aa4b52fc5d904634c9838623a74ade393"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/Caesar-github/rkwifibt"
PKG_URL="https://github.com/Caesar-github/rkwifibt/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Realtek BT FW loader"
PKG_TOOLCHAIN="make"

unpack() {
  mkdir -p ${PKG_BUILD}
  tar --strip-components=3 -xf $SOURCES/${PKG_NAME}/${PKG_NAME}-${PKG_VERSION}.tar.gz -C ${PKG_BUILD} rkwifibt-${PKG_VERSION}/realtek/rtk_hciattach
}

post_install() {
  enable_service hciattach-realtek.service
}
