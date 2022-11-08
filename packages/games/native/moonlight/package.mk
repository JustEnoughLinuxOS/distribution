# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Fewtarius

PKG_NAME="moonlight"
PKG_VERSION="28ace5187458b3bd3c9af086274d19a9bf480fff"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/moonlight-stream/moonlight-embedded"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain opus SDL2 libevdev alsa curl enet avahi"
PKG_SHORTDESC="Moonlight Embedded is an open source implementation of NVIDIA's GameStream, as used by the NVIDIA Shield, but built for Linux."
PKG_TOOLCHAIN="cmake"
GET_HANDLER_SUPPORT="git"
PKG_PATCH_DIRS+="${DEVICE}"

if [ "${PROJECT}" = "Rockchip" ]
then
  PKG_DEPENDS_TARGET+=" rkmpp"
fi

if [ ! "${OPENGL}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} glu"
fi

if [ "${OPENGLES_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]
  then
  PKG_DEPENDS_TARGET+=" vulkan-loader vulkan-headers"
fi

post_makeinstall_target() {
  mkdir -p ${INSTALL}/usr/config/moonlight
    cp -R ${PKG_BUILD}/moonlight.conf ${INSTALL}/usr/config/moonlight
    if [ "${ARCH}" = "aarch64" ] && [ -n "${SPLASH_RESOLUTION}" ]; then
      # Patch config file - stream in native screen resolution.
      sed -i "s/#width = 1280/width = ${SPLASH_RESOLUTION%x*}/g" "${INSTALL}/usr/config/moonlight/moonlight.conf"
      sed -i "s/#height = 720/height = ${SPLASH_RESOLUTION#*x}/g" "${INSTALL}/usr/config/moonlight/moonlight.conf"
    fi

	rm ${INSTALL}/usr/etc/moonlight.conf 
	rm ${INSTALL}/usr/share/moonlight/gamecontrollerdb.txt 
}
