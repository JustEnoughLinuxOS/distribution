# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="melondssa"
PKG_VERSION="00edeb3c3c053bc2b3c9ac83e33688626498f2cc"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/melonDS-emu/melonDS"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="SDL2 qt5 libslirp libepoxy libarchive ecm"
PKG_LONGDESC="DS emulator, sorta. The goal is to do things right and fast"
PKG_TOOLCHAIN="cmake"

if [ ! "${OPENGL}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} glu libglvnd"
fi

if [ "${OPENGLES_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

if [ "${DISPLAYSERVER}" = "wl" ]; then
  PKG_DEPENDS_TARGET+=" wayland ${WINDOWMANAGER} xorg-server xrandr libXi"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]
then
  PKG_DEPENDS_TARGET+=" vulkan-loader vulkan-headers"
fi

PKG_CMAKE_OPTS_TARGET+=" -DCMAKE_BUILD_TYPE=Release \
                         -DCMAKE_INSTALL_PREFIX="/usr" \
                         -DBUILD_SHARED_LIBS=OFF"


makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp -rf ${PKG_BUILD}/.${TARGET_NAME}/melonDS ${INSTALL}/usr/bin

  mkdir -p ${INSTALL}/usr/config/melonDS
  cp -rf ${PKG_DIR}/config/${DEVICE}/* ${INSTALL}/usr/config/melonDS

  cp -rf ${PKG_DIR}/scripts/* ${INSTALL}/usr/bin
  chmod +x ${INSTALL}/usr/bin/start_melonds.sh
}
