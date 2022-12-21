# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present Shanti Gilbert (https://github.com/shantigilbert)
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)
# Copyright (C) 2022-present Fewtarius

PKG_NAME="flycastsa"
PKG_VERSION="1dd006d846350e96a46949f1e07a900206ae7194"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/flyinghead/flycast"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain alsa SDL2 libzip zip curl"
PKG_LONGDESC="Flycast is a multiplatform Sega Dreamcast, Naomi and Atomiswave emulator"
PKG_TOOLCHAIN="cmake"
PKG_PATCH_DIRS+="${DEVICE}"

if [ ! "${OPENGL}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} glu libglvnd"
  PKG_CMAKE_OPTS_TARGET+="  USE_OPENGL=ON"
else
  PKG_CMAKE_OPTS_TARGET+="  USE_OPENGL=OFF"
fi

if [ "${OPENGLES_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  PKG_CMAKE_OPTS_TARGET+=" -DUSE_GLES=ON"
else
  PKG_CMAKE_OPTS_TARGET+=" -DUSE_GLES=OFF"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]
then
  PKG_DEPENDS_TARGET+=" vulkan-loader vulkan-headers"
  PKG_CMAKE_OPTS_TARGET+=" -DUSE_VULKAN=ON"
else
  PKG_CMAKE_OPTS_TARGET+=" -DUSE_VULKAN=OFF"
fi

pre_configure_target() {
export CXXFLAGS="${CXXFLAGS} -Wno-error=array-bounds"
PKG_CMAKE_OPTS_TARGET+=" -DUSE_OPENMP=ON"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp ${PKG_BUILD}/.${TARGET_NAME}/flycast ${INSTALL}/usr/bin/flycast
  cp ${PKG_DIR}/scripts/* ${INSTALL}/usr/bin

	chmod +x ${INSTALL}/usr/bin/start_flycastsa.sh
	chmod +x ${INSTALL}/usr/bin/set_flycast_joy.sh
}
