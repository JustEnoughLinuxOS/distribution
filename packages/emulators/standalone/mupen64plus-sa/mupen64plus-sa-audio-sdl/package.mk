# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="mupen64plus-sa-audio-sdl"
PKG_VERSION="8f372a02b0d3e660feba1d727b47a1eb2664404c"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/mupen64plus/mupen64plus-audio-sdl"
PKG_URL="https://github.com/mupen64plus/mupen64plus-audio-sdl/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libpng SDL2 SDL2_net zlib freetype nasm:host mupen64plus-sa-core"
PKG_SHORTDESC="mupen64plus-audio-sdl"
PKG_LONGDESC="Mupen64Plus Standalone Audio SDL"
PKG_TOOLCHAIN="manual"

if [ ! "${OPENGL}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} glu libglvnd"
fi

if [ "${OPENGLES_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

make_target() {
  case ${DEVICE} in
    AMD64)
      PKG_MAKE_OPTS_TARGET+="USE_GLES=0"
    ;;
  esac
  
  case ${ARCH} in
    arm|aarch64)
      export HOST_CPU=aarch64
      BINUTILS="$(get_build_dir binutils)/.aarch64-libreelec-linux-gnueabi"
      export USE_GLES=1
    ;;
  esac
  export APIDIR=$(get_build_dir mupen64plus-sa-core)/.install_pkg/usr/local/include/mupen64plus
  export SDL_CFLAGS="-I${SYSROOT_PREFIX}/usr/include/SDL2 -pthread"
  export SDL_LDLIBS="-lSDL2_net -lSDL2"
  export CROSS_COMPILE="${TARGET_PREFIX}"
  export V=1
  export VC=0
  make -C projects/unix clean
  make -C projects/unix all ${PKG_MAKE_OPTS_TARGET}
}

makeinstall_target() {
  UPREFIX=${INSTALL}/usr/local
  ULIBDIR=${UPREFIX}/lib
  UPLUGINDIR=${ULIBDIR}/mupen64plus
  mkdir -p ${UPLUGINDIR}
  cp ${PKG_BUILD}/projects/unix/mupen64plus-audio-sdl.so ${UPLUGINDIR}
  #${STRIP} ${UPLUGINDIR}/mupen64plus-audio-sdl.so
  chmod 0644 ${UPLUGINDIR}/mupen64plus-audio-sdl.so
}

