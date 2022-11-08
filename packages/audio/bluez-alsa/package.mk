# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2022-present Fewtarius

PKG_NAME="bluez-alsa"
PKG_VERSION="4.0.0"
PKG_SHA256="ce5e060e61669d61d44f5f9bad34a7b88378376e9d49d31482406a68127a6b29"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/Arkq/bluez-alsa"
PKG_URL="https://github.com/Arkq/bluez-alsa/archive/refs/tags/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain alsa-lib bluez sbc dbus libopenaptx"
PKG_LONGDESC="Bluetooth audio ALSA backend"
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--enable-aptx \
                           --with-libopenaptx \
			   --enable-upower \
			   --enable-a2dpconf \
			   --enable-cli"

post_makeinstall_target() {
# workaround until I figure out how to query this directory
mkdir -p ${INSTALL}/usr/lib/alsa-lib
cp -P ${PKG_BUILD}/.*/src/asound/.libs/*.so ${INSTALL}/usr/lib/alsa-lib/
rm -rf ${INSTALL}/home
#  rm -rf ${INSTALL}/lib ${INSTALL}/var
#  rm -rf ${INSTALL}/usr/share/alsa/speaker-test
#  rm -rf ${INSTALL}/usr/share/sounds
#  rm -rf ${INSTALL}/usr/lib/systemd/system
}
