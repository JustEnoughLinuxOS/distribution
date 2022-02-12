# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2021-present Fewtarius

PKG_NAME="libmali"
PKG_ARCH="arm aarch64"
PKG_LICENSE="nonfree"
PKG_SITE="https://github.com/rockchip-linux/libmali"
PKG_URL="https://github.com/JustEnoughLinuxOS/libmali.git"
PKG_VERSION="65043c1"
PKG_GIT_CLONE_DEPTH=1
GET_HANDLER_SUPPORT="git"
PKG_DEPENDS_TARGET="toolchain libdrm"
PKG_LONGDESC="OpenGL ES user-space binary for the ARM Mali GPU family"

PKG_PATCH_DIRS+="${DEVICE}"

MALIVERSION="1.9.0"

PKG_STAMP="${MALI_FAMILY}"

if [ "${TARGET_ARCH}" = "aarch64" ]; then
  INSTARCH="aarch64-linux-gnu"
elif [ "${TARGET_ARCH}" = "arm" ]; then
  INSTARCH="arm-linux-gnueabihf"
fi

PKG_CMAKE_OPTS_TARGET+=" -DMALI_ARCH=${INSTARCH}"

pre_configure_target() {
  if [ -e "${PKG_BUILD}/CMakeLists.txt" ]
  then
    sed -i "s#arm-linux-gnueabihf/libmali-bifrost-g31-rxp0-wayland-gbm.so#${INSTARCH}/${MALIDRIVER}.so#g" ${PKG_BUILD}/CMakeLists.txt 
  fi
}

post_makeinstall_target() {
  rm -f "${INSTALL}/usr/lib/*mali*"

  cp -f "${PKG_BUILD}/lib/${INSTARCH}/${MALIDRIVER}.so" "${SYSROOT_PREFIX}/usr/lib"
  cp -f "${PKG_BUILD}/lib/${INSTARCH}/${MALIDRIVER}.so" "${INSTALL}/usr/lib"

  ln -sf "${MALIDRIVER}.so" "${SYSROOT_PREFIX}/usr/lib/libmali.so.${MALIVERSION}"
  ln -sf "${MALIDRIVER}.so" "${INSTALL}/usr/lib/libmali.so.${MALIVERSION}"

  ln -sf libmali.so.${MALIVERSION} ${SYSROOT_PREFIX}/usr/lib/libvulkan.so.1
  ln -sf libmali.so.${MALIVERSION} ${INSTALL}/usr/lib/libvulkan.so.1
  ln -sf libvulkan.so.1 ${SYSROOT_PREFIX}/usr/lib/libvulkan.so
  ln -sf libvulkan.so.1 ${INSTALL}/usr/lib/libvulkan.so

  ln -sf libmali.so.${MALIVERSION} ${SYSROOT_PREFIX}/usr/lib/libmali.so.1
  ln -sf libmali.so.${MALIVERSION} ${INSTALL}/usr/lib/libmali.so.1

  ln -sf libmali.so.1 ${SYSROOT_PREFIX}/usr/lib/libmali.so
  ln -sf libmali.so.1 ${INSTALL}/usr/lib/libmali.so

  ln -sf libmali.so.1 ${SYSROOT_PREFIX}/usr/lib/libgbm.so.1
  ln -sf libgbm.so.1 ${SYSROOT_PREFIX}/usr/lib/libgbm.so
  ln -sf libmali.so.1 ${INSTALL}/usr/lib/libgbm.so.1
  ln -sf libgbm.so.1 ${INSTALL}/usr/lib/libgbm.so

  for lib in \
           libGLESv1_CM.so.1 \
           libGLESv1_CM.so \
           libGLESv2.so.2 \
           libGLESv2.so \
           libGLESv3.so.3 \
           libGLESv3.so \
           libEGL.so.1 \
           libEGL.so \
           libMaliOpenCL.so.1 \
           libMaliOpenCL.so
  do
        rm -f ${INSTALL}/usr/lib/${lib}
        ln -sf libmali.so ${INSTALL}/usr/lib/${lib}
        rm -f ${SYSROOT_PREFIX}/usr/lib/${lib}
        ln -sf libmali.so ${SYSROOT_PREFIX}/usr/lib/${lib}
  done
  rm -f $(ls ${INSTALL}/usr/lib/libmali-* | grep -v ${MALIDRIVER})
}
