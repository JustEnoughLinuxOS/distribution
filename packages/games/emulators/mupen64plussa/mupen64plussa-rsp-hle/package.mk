# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="mupen64plussa-rsp-hle"
PKG_VERSION="ca917cec14942470630515e3dd7624cf4dc29154"
PKG_ARCH="aarch64"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/mupen64plus/mupen64plus-rsp-hle"
PKG_URL="https://github.com/mupen64plus/mupen64plus-rsp-hle/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libpng SDL2 SDL2_net zlib freetype nasm:host mupen64plussa-core"
PKG_SHORTDESC="mupen64plus-rsp-hle"
PKG_LONGDESC="Mupen64Plus Standalone RSP HLE"
PKG_TOOLCHAIN="manual"

if [ ! "${OPENGL}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} glu libglvnd"
fi

if [ "${OPENGLES_SUPPORT}" = yes ]; then
  # if [ "${DEVICE}" = "RG552" ]
  # then
  #   PKG_MAKE_OPTS_TARGET+="USE_GLES=0"
  # else
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  PKG_MAKE_OPTS_TARGET+="USE_GLES=1"
  # fi
fi

make_target() {
  case ${ARCH} in
    arm|aarch64)
      export HOST_CPU=aarch64
      # if [ "${DEVICE}" = "RG552" ]
      # then
      #   export USE_GLES=0
      # else
      export USE_GLES=1
      # fi
      BINUTILS="$(get_build_dir binutils)/.aarch64-libreelec-linux-gnueabi"
    ;;
  esac
  export APIDIR=$(get_build_dir mupen64plussa-core)/.install_pkg/usr/local/include/mupen64plus
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
  cp ${PKG_BUILD}/projects/unix/mupen64plus-rsp-hle.so ${UPLUGINDIR}
  #$STRIP ${UPLUGINDIR}/mupen64plus-rsp-hle.so
  chmod 0644 ${UPLUGINDIR}/mupen64plus-rsp-hle.so
}

