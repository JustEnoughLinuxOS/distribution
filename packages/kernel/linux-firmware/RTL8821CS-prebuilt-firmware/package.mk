PKG_NAME="RTL8821CS-prebuilt-firmware"
PKG_LICENSE="Apache-2.0"
PKG_SITE="www.jelos.org"
PKG_SECTION="virtual"
PKG_LONGDESC="Realtek RTL8821CS Linux firmware"
PKG_DEPENDS_TARGET="linux"

post_install() {
  cp -v $(get_build_dir linux)/wifibt/rtk_hciattach ${INSTALL}/usr/bin
  cp -v $(get_build_dir linux)/wifibt/rtl8821c_fw ${INSTALL}/$(get_full_firmware_dir)
  cp -v $(get_build_dir linux)/wifibt/rtl8821cs_config ${INSTALL}/$(get_full_firmware_dir)/rtl8821c_config
  enable_service hciattach-realtek.service
}