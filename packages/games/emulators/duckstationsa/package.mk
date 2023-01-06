# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="duckstationsa"
PKG_LICENSE="GPLv3"
PKG_VERSION="06d6447e59f208f21ba42f4df1665b789db13fb7"
PKG_DEPENDS_TARGET="toolchain SDL2 nasm:host pulseaudio openssl libidn2 nghttp2 zlib curl libevdev ecm"
PKG_SITE="https://github.com/stenzek/duckstation"
PKG_URL="${PKG_SITE}.git"
PKG_SHORTDESC="Fast PlayStation 1 emulator for x86-64/AArch32/AArch64 "
PKG_TOOLCHAIN="cmake"
PKG_PATCH_DIRS+="${DEVICE}"

if [ ! "${OPENGL}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} glu libglvnd"
fi

if [ "${OPENGLES_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

if [ "${DISPLAYSERVER}" = "wl" ]; then
  PKG_DEPENDS_TARGET+=" wayland ${WINDOWMANAGER} xorg-server xrandr libXi"
  PKG_CMAKE_OPTS_TARGET+=" -DUSE_WAYLAND=ON"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" vulkan-loader vulkan-headers"
  PKG_CMAKE_OPTS_TARGET+=" -DENABLE_VULKAN=ON"
fi

pre_configure_target() {
	PKG_CMAKE_OPTS_TARGET+="	-DANDROID=OFF \
					-DENABLE_DISCORD_PRESENCE=OFF \
					-DBUILD_QT_FRONTEND=OFF \
					-DBUILD_NOGUI_FRONTEND=ON \
					-DCMAKE_BUILD_TYPE=Release \
					-DBUILD_SHARED_LIBS=OFF \
					-DUSE_SDL2=ON \
					-DENABLE_CHEEVOS=ON \
					-DUSE_FBDEV=OFF \
					-DUSE_EVDEV=ON \
					-DUSE_X11=OFF"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp -rf ${PKG_BUILD}/.${TARGET_NAME}/bin/duckstation-nogui ${INSTALL}/usr/bin
  cp -rf ${PKG_DIR}/scripts/* ${INSTALL}/usr/bin

  mkdir -p ${INSTALL}/usr/config/duckstation
  cp -rf ${PKG_BUILD}/.${TARGET_NAME}/bin/* ${INSTALL}/usr/config/duckstation
  cp -rf ${PKG_DIR}/config/${DEVICE}/* ${INSTALL}/usr/config/duckstation

  rm -rf ${INSTALL}/usr/config/duckstation/duckstation-nogui
  rm -rf ${INSTALL}/usr/config/duckstation/common-tests

  chmod +x ${INSTALL}/usr/bin/start_duckstation.sh
}
