# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023-present RiShooty (https://github.com/rishooty)

PKG_NAME="mupen64plus-sa-rsp-parallel"
PKG_VERSION="a3b2ef90939d06c1b0b4568fcaa89ea269081033"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/simple64/parallel-rsp"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain mupen64plus-sa-core mupen64plus-sa-simplecore"
PKG_LONGDESC="Mupen64Plus Standalone Parallel64 Rsp Driver"
PKG_TOOLCHAIN="manual"
PKG_GIT_CLONE_BRANCH="simple64"

make_target() {
  case ${ARCH} in
    aarch64|arm)
      export HOST_CPU=aarch64
    ;;
    x86_64)
      export HOST_CPU=x86_64
    ;;
  esac
  cd ${PKG_BUILD}
  rm -rf build
  mkdir build
  cd build
  APIDIR=${SYSROOT_PREFIX}/usr/local/include/mupen64plus
  cmake -G Ninja -DAPIDIR=${APIDIR} -DCMAKE_BUILD_TYPE="Release" ..
  VERBOSE=1 cmake --build .
  cp ${PKG_BUILD}/build/simple64-rsp-parallel.so ${PKG_BUILD}/build/mupen64plus-rsp-parallel-base.so
  APIDIR=${SYSROOT_PREFIX}/usr/local/include/simple64  
  cmake -G Ninja -DAPIDIR=${APIDIR} -DCMAKE_BUILD_TYPE="Release" ..
  VERBOSE=1 cmake --build .
  cp ${PKG_BUILD}/build/simple64-rsp-parallel.so ${PKG_BUILD}/build/mupen64plus-rsp-parallel-simple.so
}

makeinstall_target() {
  UPREFIX=${INSTALL}/usr/local
  ULIBDIR=${UPREFIX}/lib
  USHAREDIR=${UPREFIX}/share/mupen64plus
  UPLUGINDIR=${ULIBDIR}/mupen64plus
  mkdir -p ${UPLUGINDIR}
  cp ${PKG_BUILD}/build/mupen64plus-rsp-parallel-base.so ${UPLUGINDIR}/mupen64plus-rsp-parallel.so
  #${STRIP} ${UPLUGINDIR}/mupen64plus-rsp-parallel.so
  chmod 0644 ${UPLUGINDIR}/mupen64plus-rsp-parallel.so
  cp ${PKG_BUILD}/build/mupen64plus-rsp-parallel-simple.so ${UPLUGINDIR} 
  #${STRIP} ${UPLUGINDIR}/mupen64plus-rsp-parallel-simple.so
  chmod 0644 ${UPLUGINDIR}/mupen64plus-rsp-parallel-simple.so
}