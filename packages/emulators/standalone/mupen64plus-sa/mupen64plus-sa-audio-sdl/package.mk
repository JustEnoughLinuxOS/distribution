# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)
# Copyright (C) 2023 Nicholas Ricciuti (rishooty@gmail.com)
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="mupen64plus-sa-audio-sdl"
PKG_VERSION="cec70e42b4535ce5bd1be24e7d816c54b3e75673"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/mupen64plus/mupen64plus-audio-sdl"
PKG_URL="https://github.com/mupen64plus/mupen64plus-audio-sdl/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libpng SDL2 SDL2_net zlib freetype nasm:host mupen64plus-sa-core"
PKG_SHORTDESC="mupen64plus-audio-sdl"
PKG_LONGDESC="Mupen64Plus Standalone Audio SDL"
PKG_TOOLCHAIN="manual"

case ${DEVICE} in
  AMD64|RK3588|S922X|RK3399)
    PKG_DEPENDS_TARGET+=" mupen64plus-sa-simplecore"
  ;;
esac

case ${DEVICE} in
  AMD64|RK33*|RK3588)
    PKG_DEPENDS_TARGET+=" ${OPENGL} glu libglvnd"
    export USE_GLES=0
  ;;
  *)
    PKG_DEPENDS_TARGET+=" ${OPENGLES}"
    export USE_GLES=1
  ;;
esac

make_target() {

  export HOST_CPU=${TARGET_ARCH} \
         NEW_DYNAREC=1 \
         VFP_HARD=1 \
         V=1 \
         VC=0 \
         OSD=0

  export BINUTILS="$(get_build_dir binutils)/.${TARGET_NAME}"
  export SDL_CFLAGS="-I${SYSROOT_PREFIX}/usr/include/SDL2 -pthread -D_REENTRANT"
  export SDL_LDLIBS="-lSDL2_net -lSDL2"
  export CROSS_COMPILE="${TARGET_PREFIX}"

  export APIDIR=$(get_build_dir mupen64plus-sa-core)/src/api

  sed -i 's/\-O[23]/-Ofast/' ${PKG_BUILD}/projects/unix/Makefile

  make -C projects/unix clean
  make -C projects/unix all ${PKG_MAKE_OPTS_TARGET}
  cp ${PKG_BUILD}/projects/unix/mupen64plus-audio-sdl.so ${PKG_BUILD}/projects/unix/mupen64plus-audio-sdl-base.so

  case ${DEVICE} in
    AMD64|RK3588|S922X|RK3399)
      export APIDIR=$(get_build_dir mupen64plus-sa-simplecore)/src/api
      make -C projects/unix all ${PKG_MAKE_OPTS_TARGET}
      cp ${PKG_BUILD}/projects/unix/mupen64plus-audio-sdl.so ${PKG_BUILD}/projects/unix/mupen64plus-audio-sdl-simple.so
    ;;
  esac
}

makeinstall_target() {
  UPREFIX=${INSTALL}/usr/local
  ULIBDIR=${UPREFIX}/lib
  UPLUGINDIR=${ULIBDIR}/mupen64plus
  mkdir -p ${UPLUGINDIR}
  cp ${PKG_BUILD}/projects/unix/mupen64plus-audio-sdl-base.so ${UPLUGINDIR}/mupen64plus-audio-sdl.so
  chmod 0644 ${UPLUGINDIR}/mupen64plus-audio-sdl.so
  if [ -e "${PKG_BUILD}/projects/unix/mupen64plus-audio-sdl-simple.so" ]
  then
    cp ${PKG_BUILD}/projects/unix/mupen64plus-audio-sdl-simple.so ${UPLUGINDIR}
    chmod 0644 ${UPLUGINDIR}/mupen64plus-audio-sdl-simple.so
  fi
}

