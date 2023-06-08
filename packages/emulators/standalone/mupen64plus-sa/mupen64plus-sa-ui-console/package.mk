# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="mupen64plus-sa-ui-console"
PKG_VERSION="3ad5cbb56fcf4921ffae8c7b8ee52ea0ae82c044"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/mupen64plus/mupen64plus-ui-console"
PKG_URL="https://github.com/mupen64plus/mupen64plus-ui-console/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libpng SDL2 SDL2_net zlib freetype nasm:host mupen64plus-sa-core mupen64plus-sa-simplecore"
PKG_SHORTDESC="mupen64plus-ui-console"
PKG_LONGDESC="Mupen64Plus Standalone Console"
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
      PKG_MAKE_OPTS_TARGET+="USE_GLES=0"
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
  cp ${PKG_BUILD}/projects/unix/mupen64plus ${PKG_BUILD}/projects/unix/mupen64plus_base
  export CFLAGS="${CFLAGS} -DSIMPLECORE"
  make -C projects/unix clean
  make -C projects/unix all ${PKG_MAKE_OPTS_TARGET}
  cp ${PKG_BUILD}/projects/unix/mupen64plus ${PKG_BUILD}/projects/unix/metalCap
}

makeinstall_target() {
  UPREFIX=${INSTALL}/usr/local
  ULIBDIR=${UPREFIX}/lib
  UBINDIR=${UPREFIX}/bin
  UMANDIR=${UPREFIX}/share/man
  UAPPSDIR=${UPREFIX}/share/applications
  UICONSDIR=${UPREFIX}/share/icons/hicolor
  mkdir -p ${UBINDIR}
  cp ${PKG_BUILD}/projects/unix/mupen64plus_base ${UBINDIR}/mupen64plus
  cp ${PKG_BUILD}/projects/unix/metalCap ${UBINDIR}
  #${STRIP} ${UBINDIR}/mupen64plus
  #${STRIP} ${UBINDIR}/metalCap
  chmod 0755 ${UBINDIR}/mupen64plus
  chmod 0755 ${UBINDIR}/metalCap
  mkdir -p ${UMANDIR}/man6
  cp ${PKG_BUILD}/doc/mupen64plus.6 ${UMANDIR}/man6
  chmod 0644 ${UMANDIR}/man6/mupen64plus.6
  mkdir -p ${UAPPSDIR}
  cp ${PKG_BUILD}/data/mupen64plus.desktop ${UAPPSDIR}
  chmod 0644 ${UAPPSDIR}/mupen64plus.desktop
  mkdir -p ${UICONSDIR}/48x48/apps
  cp ${PKG_BUILD}/data/icons/48x48/apps/mupen64plus.png ${UICONSDIR}/48x48/apps
  chmod 0644 ${UICONSDIR}/48x48/apps/mupen64plus.png
  mkdir -p ${UICONSDIR}/scalable/apps
  cp ${PKG_BUILD}/data/icons/scalable/apps/mupen64plus.svg ${UICONSDIR}/scalable/apps
  chmod 0644 ${UICONSDIR}/scalable/apps/mupen64plus.svg
}

