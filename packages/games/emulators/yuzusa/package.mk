# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="yuzusa"
PKG_VERSION="cbcf210c19b3661e0edda03f22ef323cb5b30c26"
PKG_ARCH="x86_64"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/yuzu-emu/yuzu"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain libfmt boost ffmpeg zstd zlib libzip lz4 opus libusb nlohmann-json"
PKG_SHORTDESC="Nintendo Switch emulator"
PKG_TOOLCHAIN="cmake"
GET_HANDLER_SUPPORT="git"

if [ ! "${OPENGL}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} glu libglvnd"
  PKG_CONFIGURE_OPTS_TARGET+=" -DENABLE_X11=OFF"
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

PKG_CMAKE_OPTS_TARGET+="        -DENABLE_QT=OFF \
                                -DCMAKE_BUILD_TYPE=Release \
                                -DYUZU_USE_BUNDLED_SDL2=OFF \
                                -DYUZU_USE_BUNDLED_QT=OFF \
                                -DYUZU_TESTS=OFF \
                                -DENABLE_SDL2=ON \
                                -DARCHITECTURE_x86_64=ON \
                                -DBUILD_SHARED_LIBS=OFF \
				-DENABLE_WEB_SERVICE=OFF \
                                -DUSE_DISCORD_PRESENCE=OFF"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp -rf ${PKG_BUILD}/.${TARGET_NAME}/bin/yuzu* ${INSTALL}/usr/bin
  cp -rf ${PKG_DIR}/scripts/* ${INSTALL}/usr/bin

  chmod +x ${INSTALL}/usr/bin/start_yuzu.sh

  mkdir -p ${INSTALL}/usr/config/yuzu
  cp -rf ${PKG_DIR}/config/* ${INSTALL}/usr/config/yuzu
}
