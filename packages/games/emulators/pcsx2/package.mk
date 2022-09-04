# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present Fewtarius

PKG_NAME="pcsx2"
PKG_VERSION="b96594b17cb362d381e291232b490142fd615382"
PKG_ARCH="x86_64"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/pcsx2/pcsx2"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain alsa-lib freetype zlib libpng libaio libsamplerate libfmt libpcap soundtouch yamlcpp"
PKG_LONGDESC="PS2 Emulator"
GET_HANDLER_SUPPORT="git"

PKG_PATCH_DIRS+="${DEVICE}"

if [ ! "${OPENGL}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} glu libglvnd"
fi

if [ "${OPENGLES_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]
then
  PKG_DEPENDS_TARGET+=" vulkan-loader vulkan-headers"
fi

if [ "${DISPLAYSERVER}" = "wl" ]; then
  PKG_DEPENDS_TARGET+=" wayland ${WINDOWMANAGER}"
fi

PKG_CMAKE_OPTS_TARGET=" -DwxWidgets_CONFIG_EXECUTABLE=${SYSROOT_PREFIX}/usr/bin/wx-config \
-DXDG_STD=TRUE \
-DSDL2_API=TRUE \
-DDISABLE_PCSX2_WRAPPER=1 \
-DPACKAGE_MODE=FALSE \
-DPCSX2_TARGET_ARCHITECTURES=x86_64 \
-DENABLE_TESTS=OFF \
-DEXTRA_PLUGINS=TRUE \
-DQT_BUILD=FALSE \
-DBUILD_SHARED_LIBS=ON \
-DUSE_SYSTEM_LIBS=AUTO \
-DDISABLE_ADVANCE_SIMD=ON \
-DUSE_VTUNE=OFF \
-DUSE_VULKAN=ON \
-DCMAKE_INTERPROCEDURAL_OPTIMIZATION=FALSE \
-DCMAKE_BUILD_TYPE=Release"

