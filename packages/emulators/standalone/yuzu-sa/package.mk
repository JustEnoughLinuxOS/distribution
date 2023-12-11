# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present - The JELOS Project (https://github.com/JustEnoughLinuxOS)

PKG_NAME="yuzu-sa"
PKG_VERSION="875568bb3e34725578f7fa3661c8bad89f23a173"
PKG_ARCH="x86_64"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/yuzu-emu/yuzu"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain libfmt boost ffmpeg zstd zlib libzip lz4 opus libusb nlohmann-json qt5"
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
  PKG_DEPENDS_TARGET+=" wayland ${WINDOWMANAGER} xwayland xrandr libXi"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]
then
  PKG_DEPENDS_TARGET+=" vulkan-loader vulkan-headers"
fi

PKG_CMAKE_OPTS_TARGET+="        -DENABLE_QT=ON \
                                -DCMAKE_BUILD_TYPE=Release \
                                -DYUZU_USE_BUNDLED_SDL2=OFF \
                                -DYUZU_USE_BUNDLED_QT=OFF \
                                -DYUZU_TESTS=OFF \
                                -DENABLE_SDL2=ON \
                                -DARCHITECTURE_x86_64=ON \
                                -DBUILD_SHARED_LIBS=OFF \
				-DENABLE_WEB_SERVICE=OFF \
				-DENABLE_COMPATIBILITY_LIST_DOWNLOAD=ON \
				-DYUZU_USE_BUNDLED_FFMPEG=OFF \
				-DYUZU_USE_EXTERNAL_VULKAN_HEADERS=OFF \
				-DYUZU_USE_EXTERNAL_SDL2=OFF \
				-DYUZU_USE_FASTER_LD=OFF \
				-DYUZU_USE_PRECOMPILED_HEADERS=OFF \
				-DYUZU_USE_QT_MULTIMEDIA=ON \
				-DYUZU_USE_QT_WEB_ENGINE=OFF \
                                -DUSE_DISCORD_PRESENCE=OFF"
pre_configure_target() {
  CFLAGS=$(echo ${CFLAGS} | sed -e "s|-Ofast|-O3|")
  CXXFLAGS=$(echo ${CXXFLAGS} | sed -e "s|-Ofast|-O3|")
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp -rf ${PKG_BUILD}/.${TARGET_NAME}/bin/yuzu* ${INSTALL}/usr/bin
  cp -rf ${PKG_DIR}/scripts/* ${INSTALL}/usr/bin

  chmod +x ${INSTALL}/usr/bin/start_yuzu.sh

  mkdir -p ${INSTALL}/usr/config/yuzu
  cp -rf ${PKG_DIR}/config/* ${INSTALL}/usr/config/yuzu
}
