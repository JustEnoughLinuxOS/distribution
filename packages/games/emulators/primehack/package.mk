# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="primehack"
PKG_LICENSE="GPLv2"
PKG_DEPENDS_TARGET="toolchain libevdev libdrm ffmpeg zlib libpng lzo libusb zstd ecm"
PKG_SITE="https://github.com/shiiion/dolphin"
PKG_URL="${PKG_SITE}.git"
PKG_VERSION="55330bfebbcde86c169715c25f2b693cbbe55a75"
PKG_LONGDESC="PrimeHack – A Dolphin Emulator fork for Metroid Prime Trilogy."
PKG_PATCH_DIRS+=" wayland"

if [ ! "${OPENGL}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} glu libglvnd"
  PKG_CMAKE_OPTS_TARGET+="     -DENABLE_X11=OFF \
                               -DENABLE_EGL=ON"
fi

if [ "${OPENGLES_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  PKG_CMAKE_OPTS_TARGET+="     -DENABLE_X11=OFF \
                               -DENABLE_EGL=ON"
fi

if [ "${DISPLAYSERVER}" = "wl" ]; then
  PKG_DEPENDS_TARGET+=" wayland ${WINDOWMANAGER} xorg-server xrandr libXi"
  PKG_CMAKE_OPTS_TARGET+="     -DENABLE_WAYLAND=ON \
                               -DENABLE_X11=OFF"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]
then
  PKG_DEPENDS_TARGET+=" vulkan-loader vulkan-headers"
  PKG_CMAKE_OPTS_TARGET+=" -DENABLE_VULKAN=ON"
fi

PKG_CMAKE_OPTS_TARGET+=" -DENABLE_HEADLESS=ON \
                         -DENABLE_EVDEV=ON \
                         -DUSE_DISCORD_PRESENCE=OFF \
                         -DBUILD_SHARED_LIBS=OFF \
                         -DUSE_MGBA=OFF \
                         -DLINUX_LOCAL_DEV=ON \
                         -DENABLE_TESTS=OFF \
                         -DENABLE_LLVM=OFF \
                         -DENABLE_ANALYTICS=OFF \
                         -DENABLE_LTO=ON \
                         -DENABLE_QT=OFF \
                         -DENCODE_FRAMEDUMPS=OFF \
                         -DENABLE_CLI_TOOL=OFF"


makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp -rf ${PKG_BUILD}/.${TARGET_NAME}/Binaries/primehack* ${INSTALL}/usr/bin
  cp -rf ${PKG_DIR}/scripts/* ${INSTALL}/usr/bin

  chmod +x ${INSTALL}/usr/bin/start_primehack.sh

  mkdir -p ${INSTALL}/usr/config/primehack
  cp -rf ${PKG_BUILD}/Data/Sys/* ${INSTALL}/usr/config/primehack
  cp -rf ${PKG_DIR}/config/${DEVICE}/* ${INSTALL}/usr/config/primehack
}
