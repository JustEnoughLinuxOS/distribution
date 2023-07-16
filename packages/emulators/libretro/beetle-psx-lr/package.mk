# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="beetle-psx-lr"
PKG_VERSION="379793f1005b1d8810b99f81fe7b5f9126831c89"
PKG_LICENSE="GPLv2"
PKG_SITE="https://git.libretro.com/libretro/beetle-psx-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="Fork of Mednafen PSX"
PKG_TOOLCHAIN="make"

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

PKG_MAKE_OPTS_TARGET+=" LINK_STATIC_LIBCPLUSPLUS=0"

case ${DEVICE} in
  AMD64)
    PKG_MAKE_OPTS_TARGET+=" HAVE_HW=1"
  ;;
esac

makeinstall_target() {

mkdir -p ${INSTALL}/usr/lib/libretro

case ${DEVICE} in
  AMD64)
    cp mednafen_psx_hw_libretro.so ${INSTALL}/usr/lib/libretro/beetle_psx_libretro.so
    cp -vP ${PKG_BUILD}/../core-info-*/beetle_psx_hw_libretro.info ${INSTALL}/usr/lib/libretro/beetle_psx_libretro.info
    sed -i 's/Beetle PSX HW/Beetle PSX/g' ${INSTALL}/usr/lib/libretro/beetle_psx_libretro.info
  ;;
  *)
    cp mednafen_psx_libretro.so ${INSTALL}/usr/lib/libretro/beetle_psx_libretro.so
  ;;
esac
}
