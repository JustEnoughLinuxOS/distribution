# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2022-present Marek Moeckel (wansti@discarded-ideas.org)

PKG_NAME="bluez-alsa"
PKG_VERSION="4.0.0"
PKG_SHA256="ce5e060e61669d61d44f5f9bad34a7b88378376e9d49d31482406a68127a6b29"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/Arkq/bluez-alsa"
PKG_URL="https://github.com/Arkq/bluez-alsa/archive/refs/tags/v${PKG_VERSION}.tar.gz"
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
# workaround until I figure out how to query this directory
mkdir -p ${INSTALL}/usr/lib/alsa-lib
cp -P ${PKG_BUILD}/.*/src/asound/.libs/*.so ${INSTALL}/usr/lib/alsa-lib/
sed -i ${INSTALL}/etc/dbus-1/system.d/bluealsa.conf -e "s|audio|root|g"
sed -i ${INSTALL}/usr/lib/systemd/system/bluealsa.service \
  -e "s|ExecStart=.*|ExecStart=/usr/bin/bluealsa -p a2dp-source -p a2dp-sink -c aptx -c aac -c ldac|g"
rm -rf ${INSTALL}/home
}

post_install() {
  enable_service bluealsa.service
}
