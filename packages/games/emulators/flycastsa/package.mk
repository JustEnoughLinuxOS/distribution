# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present Shanti Gilbert (https://github.com/shantigilbert)
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)
# Copyright (C) 2022-present Fewtarius

PKG_NAME="flycastsa"
PKG_VERSION="baab70c509093dcd2f64ccbc53935c06fb5ac9f9"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/flyinghead/flycast"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain ${OPENGLES} alsa SDL2 libzip zip"
PKG_LONGDESC="Flycast is a multiplatform Sega Dreamcast, Naomi and Atomiswave emulator"
PKG_TOOLCHAIN="cmake"
PKG_PATCH_DIRS+="${DEVICE}"

pre_configure_target() {
export CXXFLAGS="${CXXFLAGS} -Wno-error=array-bounds"
PKG_CMAKE_OPTS_TARGET+="-DUSE_GLES=ON \
			-DUSE_VULKAN=OFF \
			-DUSE_OPENMP=ON"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp ${PKG_BUILD}/.${TARGET_NAME}/flycast ${INSTALL}/usr/bin/flycast
  cp ${PKG_DIR}/scripts/* ${INSTALL}/usr/bin

	chmod +x ${INSTALL}/usr/bin/start_flycastsa.sh
	chmod +x ${INSTALL}/usr/bin/set_flycast_joy.sh
}
