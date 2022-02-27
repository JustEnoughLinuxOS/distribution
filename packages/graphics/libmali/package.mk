# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2021-present Fewtarius

PKG_NAME="libmali"
PKG_ARCH="arm aarch64"
PKG_LICENSE="nonfree"
PKG_SITE="https://github.com/JustEnoughLinuxOS/libmali"
PKG_URL="${PKG_SITE}.git"
PKG_VERSION="7d7e1a4"
MALI_LIB_VERSION="1.9.0"
GET_HANDLER_SUPPORT="git"
PKG_DEPENDS_TARGET="toolchain libdrm"
PKG_LONGDESC="OpenGL ES user-space binary for the ARM Mali GPU family"
PKG_PATCH_DIRS+="${DEVICE}"

if [ "${TARGET_ARCH}" = "aarch64" ]; then
  INSTARCH="aarch64-linux-gnu"
elif [ "${TARGET_ARCH}" = "arm" ]; then
  INSTARCH="arm-linux-gnueabihf"
fi

PKG_CMAKE_OPTS_TARGET+=" -DMALI_ARCH=${INSTARCH}"

PKG_MESON_OPTS_TARGET+=" -Darch=${TARGET_ARCH} \
                         -Dgpu=${MALI_FAMILY} \
                         -Dversion=${MALI_VERSION} \
                         -Dplatform=gbm \
                         -Dkhr-header=true"

post_makeinstall_target() {
  for lib in libEGL.so.1 libgbm.so.1 libGLESv1_CM.so.1 libGLESv2.so.2 libMaliOpenCL.so.1
  do
    rm -f ${PKG_BUILD}/.install_pkg/usr/lib/${lib}
    ln -s libmali.so.${MALI_LIB_VERSION} ${PKG_BUILD}/.install_pkg/usr/lib/${lib}
  done
}
