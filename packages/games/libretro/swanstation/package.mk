# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Shanti Gilbert (https://github.com/shantigilbert)
# Maintenance 2020 351ELEC team (https://github.com/fewtarius/351ELEC)

PKG_NAME="swanstation"
PKG_VERSION="299f0638194ed3a7e899d6ef6e08b34a45f1e3fc"
PKG_SHA256="add1993c4afc6406c36dd606d77e6254a38f53b35ef098b0402e8f2cb4eb09b4"
PKG_ARCH="aarch64"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/swanstation"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain nasm:host"
PKG_SECTION="libretro"
PKG_SHORTDESC="SwanStation - PlayStation 1, aka. PSX Emulator"
PKG_TOOLCHAIN="cmake"
PKG_BUILD_FLAGS="-lto"

if [ ! "${OPENGL}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} glu libglvnd"
fi

if [ "${OPENGLES_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

pre_configure_target() {
 PKG_CMAKE_OPTS_TARGET+=" -DCMAKE_BUILD_TYPE=Release -DBUILD_LIBRETRO_CORE=ON "
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp $PKG_BUILD/.$TARGET_NAME/swanstation_libretro.so $INSTALL/usr/lib/libretro/
}
