# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="vitaquake2-lr"
PKG_VERSION="6bb3ee592169694b055e7efd5fa2a4e57875bddd"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/vitaquake2"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="Libretro port of VitaQuakeII (Quake 2 engine)"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
elif [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

pre_make_target() {
  export BUILD_SYSROOT=${SYSROOT_PREFIX}

  PKG_MAKE_OPTS_TARGET+=" platform=${DEVICE}"
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp vitaquake2_libretro.so $INSTALL/usr/lib/libretro/
}
