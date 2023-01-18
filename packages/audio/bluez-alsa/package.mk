# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present Marek Moeckel (wansti@discarded-ideas.org)
# Copyright (C) 2022-present Fewtarius

PKG_NAME="bluez-alsa"
PKG_VERSION="8d2c94d"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/Arkq/bluez-alsa"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain alsa-lib bluez sbc dbus libopenaptx fdk-aac libldac"
PKG_LONGDESC="Bluetooth audio ALSA backend"
PKG_TOOLCHAIN="autotools"

if build_with_debug; then
  PKG_BLUEALSA_DEBUG=--with-debug
fi

PKG_CONFIGURE_OPTS_TARGET="${PKG_BLUEALSA_DEBUG} \
			   --enable-aptx \
                           --with-libopenaptx \
			   --enable-aac \
			   --enable-ldac \
			   --enable-upower \
			   --enable-a2dpconf \
			   --enable-cli \
			   --enable-systemd"

post_makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/services
  mkdir -p ${INSTALL}/usr/lib/systemd/system
  cp -P ${PKG_DIR}/default.d/*.conf ${INSTALL}/usr/share/services/
  cp -P ${PKG_DIR}/system.d/*.service ${INSTALL}/usr/lib/systemd/system/

  # workaround until I figure out how to query this directory
  mkdir -p ${INSTALL}/usr/lib/alsa-lib
  cp -P ${PKG_BUILD}/.*/src/asound/.libs/*.so ${INSTALL}/usr/lib/alsa-lib/
  sed -i ${INSTALL}/etc/dbus-1/system.d/bluealsa.conf -e "s|audio|root|g"
  rm -rf ${INSTALL}/home
}

post_install() {
  enable_service bluealsa.service
  enable_service bluealsa-defaults.service
}
