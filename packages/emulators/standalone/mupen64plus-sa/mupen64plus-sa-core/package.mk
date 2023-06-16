# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="mupen64plus-sa-core"
PKG_VERSION="d4f3e12db0609158c7b4e0beef2bb950aad0ccb9"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/mupen64plus/mupen64plus-core"
PKG_URL="https://github.com/mupen64plus/mupen64plus-core/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain boost libpng SDL2 SDL2_net zlib freetype nasm:host"
PKG_SHORTDESC="mupen64plus"
PKG_LONGDESC="Mupen64Plus Standalone"
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
  export NEW_DYNAREC=1
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
  cp ${PKG_BUILD}/projects/unix/libmupen64plus.so.2.0.0 ${INSTALL}/usr/local/lib
  chmod 644 ${INSTALL}/usr/local/lib/libmupen64plus.so.2.0.0
  cp ${PKG_BUILD}/projects/unix/libmupen64plus.so.2 ${INSTALL}/usr/local/lib
  mkdir -p ${INSTALL}/usr/local/share/mupen64plus
  cp ${PKG_BUILD}/data/* ${INSTALL}/usr/local/share/mupen64plus
  chmod 0644 ${INSTALL}/usr/local/share/mupen64plus/*
  mkdir -p ${SYSROOT_PREFIX}/usr/local/include/mupen64plus
  find ${PKG_BUILD}/src -name "*.h" -exec cp \{} ${SYSROOT_PREFIX}/usr/local/include/mupen64plus/ \;
  chmod 0644 ${SYSROOT_PREFIX}/usr/local/include/mupen64plus/*

  if [ -e "${PKG_DIR}/config/${DEVICE}/mupen64plus.cfg" ]
  then
    cp ${PKG_DIR}/config/${DEVICE}/* ${INSTALL}/usr/local/share/mupen64plus/
    chmod 644 ${INSTALL}/usr/local/share/mupen64plus/mupen64plus.cfg
  fi

  mkdir -p ${INSTALL}/usr/bin
  cp ${PKG_DIR}/scripts/start_mupen64plus.sh ${INSTALL}/usr/bin
  chmod 755 ${INSTALL}/usr/bin/start_mupen64plus.sh
}

