# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Fewtarius

PKG_NAME="moonlight"
PKG_VERSION="543dc087fce7473b87bbaef47a350c49f8aa3fd1"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/moonlight-stream/moonlight-embedded"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain opus libevdev alsa enet"
PKG_SHORTDESC="Moonlight Embedded is an open source implementation of NVIDIA's GameStream, as used by the NVIDIA Shield, but built for Linux."
PKG_TOOLCHAIN="cmake"
GET_HANDLER_SUPPORT="git"
PKG_PATCH_DIRS+="${DEVICE}"

post_makeinstall_target() {
  mkdir -p $INSTALL/usr/config/moonlight
    cp -R $PKG_BUILD/moonlight.conf $INSTALL/usr/config/moonlight

	rm ${INSTALL}/usr/etc/moonlight.conf 
	rm ${INSTALL}/usr/share/moonlight/gamecontrollerdb.txt 
}
