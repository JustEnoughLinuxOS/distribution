# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="citra-lr"
PKG_VERSION="d7e1612c17b1acb5d5eb68bb046820db49aeea5e"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/citra"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain boost"
PKG_SECTION="libretro"
PKG_SHORTDESC="Citra - Nintendo 3DS emulator for libretro"
PKG_TOOLCHAIN="make"

if [ ! "${OPENGL}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} glu libglvnd"
fi

if [ "${OPENGLES_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

pre_make_target() {

  cd ${PKG_BUILD}
  if [ -e "CMakeLists.txt" ]
  then
    rm CMakeLists.txt
  fi

  PKG_MAKE_OPTS_TARGET="GIT_REV=${PKG_VERSION:0:7} \
                        HAVE_FFMPEG_STATIC=1 \
                        FFMPEG_DISABLE_VDPAU=1 \
                        HAVE_FFMPEG_CROSSCOMPILE=1 \
                        FFMPEG_XC_CPU=${TARGET_CPU} \
                        FFMPEG_XC_ARCH=${TARGET_ARCH} \
                        FFMPEG_XC_PREFIX=${TARGET_PREFIX} \
                        FFMPEG_XC_SYSROOT=${SYSROOT_PREFIX} \
                        FFMPEG_XC_NM=${NM} \
                        FFMPEG_XC_AR=${AR} \
                        FFMPEG_XC_AS=${CC} \
                        FFMPEG_XC_CC=${CC} \
                        FFMPEG_XC_LD=${CC}"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp citra_libretro.so ${INSTALL}/usr/lib/libretro/
}
