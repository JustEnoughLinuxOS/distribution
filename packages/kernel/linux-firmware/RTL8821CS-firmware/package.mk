# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2022-present Brooksytech
# Copyright (C) 2022-present Fewtarius

PKG_NAME="RTL8821CS-firmware"
PKG_VERSION="$(date +%Y%m%d)"
PKG_LICENSE="Apache-2.0"
PKG_SITE="www.jelos.org"
PKG_LONGDESC="Realtek RTL8821CS Linux firmware"
PKG_DEPENDS_TARGET="linux"
PKG_TOOLCHAIN="manual"

make_target() {
  : 
}

makeinstall_target() {
  cp -v $(get_build_dir linux)/wifibt/rtk_hciattach ${INSTALL}/usr/bin
  cp -v $(get_build_dir linux)/wifibt/rtl8821c_fw ${INSTALL}/$(get_full_firmware_dir)
  cp -v $(get_build_dir linux)/wifibt/rtl8821cs_config ${INSTALL}/$(get_full_firmware_dir)/rtl8821c_config
}

post_install() {
  enable_service hciattach-realtek.service
}
