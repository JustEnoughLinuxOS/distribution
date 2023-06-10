# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023-present RiShooty (https://github.com/rishooty)

PKG_NAME="mupen64plus-sa-video-parallel"
PKG_VERSION="3a97537ebe99b6c53420a52a038659931f606ab7"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/rishooty/parallel-rdp-standalone"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain mupen64plus-sa-core mupen64plus-sa-simplecore"
PKG_LONGDESC="Mupen64Plus Standalone Parallel64 Video Driver"
PKG_TOOLCHAIN="manual"
PKG_GIT_CLONE_BRANCH="ci-m64p"

if [ ! "${OPENGL}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} glu libglvnd"
fi
if [ "${OPENGLES_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

make_target() {
  case ${ARCH} in
    aarch64|arm)
      export HOST_CPU=aarch64
      export USE_GLES=1
    ;;
    x86_64)
      export HOST_CPU=x86_64
	    export USE_GLES=0
    ;;
  esac
  cd ${PKG_BUILD}
  rm -rf build
  mkdir build
  cd build
  APIDIR=${SYSROOT_PREFIX}/usr/local/include/mupen64plus
  cmake -DAPIDIR=${APIDIR} ..
  cmake --build . --parallel
  cp ${PKG_BUILD}/build/mupen64plus-video-parallel.so ${PKG_BUILD}/build/mupen64plus-video-parallel-base.so
  APIDIR=${SYSROOT_PREFIX}/usr/local/include/simple64  
  cmake -DAPIDIR=${APIDIR} ..
  cmake --build . --parallel
  cp ${PKG_BUILD}/build/mupen64plus-video-parallel.so ${PKG_BUILD}/build/mupen64plus-video-parallel-simple.so
}

makeinstall_target() {
  UPREFIX=${INSTALL}/usr/local
  ULIBDIR=${UPREFIX}/lib
  USHAREDIR=${UPREFIX}/share/mupen64plus
  UPLUGINDIR=${ULIBDIR}/mupen64plus
  mkdir -p ${UPLUGINDIR}
  cp ${PKG_BUILD}/build/mupen64plus-video-parallel-base.so ${UPLUGINDIR}/mupen64plus-video-parallel.so
  #${STRIP} ${UPLUGINDIR}/mupen64plus-video-parallel.so
  chmod 0644 ${UPLUGINDIR}/mupen64plus-video-parallel.so
  cp ${PKG_BUILD}/build/mupen64plus-video-parallel-simple.so ${UPLUGINDIR} 
  #${STRIP} ${UPLUGINDIR}/mupen64plus-video-parallel-simple.so
  chmod 0644 ${UPLUGINDIR}/mupen64plus-video-parallel-simple.so
}