# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="mupen64plus-sa-simplecore"
PKG_VERSION="fb8f54ccfe78215e2d3b3e91a7e8ffae2b755455"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/simple64/mupen64plus-core"
PKG_URL="https://github.com/simple64/mupen64plus-core/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain boost libpng SDL2 SDL2_net zlib freetype nasm:host mupen64plus-sa-core"
PKG_SHORTDESC="simple64"
PKG_LONGDESC="Simple64's core"
PKG_TOOLCHAIN="manual"

if [ ! "${OPENGL}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} glu libglvnd"
fi

if [ "${OPENGLES_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

make_target() {
  case ${ARCH} in
    arm|aarch64)
      export HOST_CPU=aarch64
      BINUTILS="$(get_build_dir binutils)/.aarch64-libreelec-linux-gnueabi"
      export USE_GLES=1
    ;;
    x86_64)
      export HOST_CPU=x86_64
      export USE_GLES=0
    ;;
  esac
  export SDL_CFLAGS="-I${SYSROOT_PREFIX}/usr/include/SDL2 -pthread"
  export SDL_LDLIBS="-lSDL2_net -lSDL2"
  export CROSS_COMPILE="${TARGET_PREFIX}"
  export V=1
  export VC=0
  export OSD=0
  make -C projects/unix clean
  make -C projects/unix all ${PKG_MAKE_OPTS_TARGET}
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/local/lib
  cp ${PKG_BUILD}/projects/unix/libsimple64.so.2.0.0 ${INSTALL}/usr/local/lib
  chmod 644 ${INSTALL}/usr/local/lib/libsimple64.so.2.0.0
  cp ${PKG_BUILD}/projects/unix/libsimple64.so.2 ${INSTALL}/usr/local/lib
  mkdir -p ${SYSROOT_PREFIX}/usr/local/include/simple64
  cp ${PKG_BUILD}/src/api/m64p_*.h ${SYSROOT_PREFIX}/usr/local/include/simple64
  chmod 0644 ${SYSROOT_PREFIX}/usr/local/include/simple64/*
}