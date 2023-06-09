# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="mupen64plus-sa-input-sdl"
PKG_VERSION="aa181483bfcac8901184f8c7590e4246eba5508b"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/mupen64plus/mupen64plus-input-sdl"
PKG_URL="https://github.com/mupen64plus/mupen64plus-input-sdl/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libpng SDL2 SDL2_net zlib freetype nasm:host mupen64plus-sa-core mupen64plus-sa-simplecore"
PKG_SHORTDESC="mupen64plus-input-sdl"
PKG_LONGDESC="Mupen64Plus Standalone Input SDL"
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
  export APIDIR=${SYSROOT_PREFIX}/usr/local/include/mupen64plus
  export SDL_CFLAGS="-I${SYSROOT_PREFIX}/usr/include/SDL2 -pthread"
  export SDL_LDLIBS="-lSDL2_net -lSDL2"
  export CROSS_COMPILE="${TARGET_PREFIX}"
  export V=1
  export VC=0
  make -C projects/unix clean
  make -C projects/unix all ${PKG_MAKE_OPTS_TARGET}
  cp ${PKG_BUILD}/projects/unix/mupen64plus-input-sdl.so ${PKG_BUILD}/projects/unix/mupen64plus-input-sdl-base.so
  export APIDIR=${SYSROOT_PREFIX}/usr/local/include/simple64
  make -C projects/unix clean
  make -C projects/unix all ${PKG_MAKE_OPTS_TARGET}
  cp ${PKG_BUILD}/projects/unix/mupen64plus-input-sdl.so ${PKG_BUILD}/projects/unix/mupen64plus-input-sdl-simple.so
}

makeinstall_target() {
  UPREFIX=${INSTALL}/usr/local
  ULIBDIR=${UPREFIX}/lib
  USHAREDIR=${UPREFIX}/share/mupen64plus
  UPLUGINDIR=${ULIBDIR}/mupen64plus
  mkdir -p ${UPLUGINDIR}
  cp ${PKG_BUILD}/projects/unix/mupen64plus-input-sdl-base.so ${UPLUGINDIR}/mupen64plus-input-sdl.so
  #${STRIP} ${UPLUGINDIR}/mupen64plus-input-sdl.so
  chmod 0644 ${UPLUGINDIR}/mupen64plus-input-sdl.so
  cp ${PKG_BUILD}/projects/unix/mupen64plus-input-sdl-simple.so ${UPLUGINDIR}
  #${STRIP} ${UPLUGINDIR}/mupen64plus-input-sdl-simple.so
  chmod 0644 ${UPLUGINDIR}/mupen64plus-input-sdl-simple.so
  mkdir -p ${USHAREDIR}
  cp ${PKG_DIR}/config/${DEVICE}/* ${USHAREDIR}
}
