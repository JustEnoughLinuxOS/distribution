# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="duckstationsa"
PKG_LICENSE="GPLv3"
PKG_DEPENDS_TARGET="toolchain SDL2 nasm:host pulseaudio openssl libidn2 nghttp2 zlib curl libevdev"
PKG_SITE="https://github.com/stenzek/duckstation"
PKG_URL="${PKG_SITE}.git"
PKG_SHORTDESC="Fast PlayStation 1 emulator for x86-64/AArch32/AArch64 "

case ${DEVICE} in
  RG552|handheld)
    PKG_VERSION="b3d074a4807bd0fadd7af41555c4f29b1159dcd7"
    PKG_PATCH_DIRS+=" new"
  ;;
  *)
    PKG_VERSION="5ab5070d73f1acc51e064bd96be4ba6ce3c06f5c"
    PKG_PATCH_DIRS+=" legacy"
  ;;
esac

if [ ! "${OPENGL}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} glu libglvnd"
  PKG_CONFIGURE_OPTS_TARGET+=" -DUSE_X11=OFF"
fi

if [ "${OPENGLES_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  PKG_CONFIGURE_OPTS_TARGET+=" 	-DUSE_X11=OFF \
				-DUSE_DRMKMS=ON \
				-DENABLE_EGL=ON \
				-DUSE_MALI=OFF"
fi

if [ "${DISPLAYSERVER}" = "wl" ]; then
  PKG_DEPENDS_TARGET+=" wayland ${WINDOWMANAGER} xorg-server xrandr libXi"
  PKG_CONFIGURE_OPTS_TARGET+=" -DUSE_X11=ON"
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
					-DUSE_WAYLAND=OFF \
					-DENABLE_VULKAN=OFF
					-DUSE_EVDEV=ON"
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
