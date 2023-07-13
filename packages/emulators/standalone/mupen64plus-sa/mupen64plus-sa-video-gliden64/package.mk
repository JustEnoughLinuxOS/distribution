# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="mupen64plus-sa-video-gliden64"
PKG_VERSION="0fee30d010d1feda7d343654871b3dfd05ccab70"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/gonetz/GLideN64"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain boost libpng SDL2 SDL2_net zlib freetype nasm:host mupen64plus-sa-core"
PKG_SHORTDESC="mupen64plus-video-gliden64"
PKG_LONGDESC="Mupen64Plus Standalone GLide64 Video Driver"
PKG_TOOLCHAIN="manual"

case ${DEVICE} in
  AMD64|RK3588|S922X)
    PKG_DEPENDS_TARGET="mupen64plus-sa-simplecore"
  ;;
esac

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
      PKG_MAKE_OPTS_TARGET+="-DNOHQ=On -DCRC_ARMV8=On -DEGL=On -DNEON_OPT=On"
    ;;
    x86_64)
      export HOST_CPU=x86_64
      export USE_GLES=0
    ;;
  esac
  APIDIR=${SYSROOT_PREFIX}/usr/local/include/mupen64plus
  export SDL_CFLAGS="-I${SYSROOT_PREFIX}/usr/include/SDL2 -pthread"
  export SDL_LDLIBS="-lSDL2_net -lSDL2"
  export CROSS_COMPILE="${TARGET_PREFIX}"
  export V=1
  export VC=0
  ./src/getRevision.sh
  cmake ${PKG_MAKE_OPTS_TARGET} -DAPIDIR=${APIDIR} -DMUPENPLUSAPI=On -DGLIDEN64_BUILD_TYPE=Release -DCMAKE_C_COMPILER="${CC}" -DCMAKE_CXX_COMPILER="${CXX}" -DCMAKE_C_FLAGS="${CFLAGS}" -DCMAKE_CXX_FLAGS="${CXXFLAGS} -pthread" -S src -B projects/cmake
  make clean -C projects/cmake
  make -Wno-unused-variable -C projects/cmake
  cp ${PKG_BUILD}/projects/cmake/plugin/Release/mupen64plus-video-GLideN64.so ${PKG_BUILD}/projects/cmake/plugin/Release/mupen64plus-video-GLideN64-base.so
  APIDIR=${SYSROOT_PREFIX}/usr/local/include/simple64
  cmake ${PKG_MAKE_OPTS_TARGET} -DAPIDIR=${APIDIR} -DMUPENPLUSAPI=On -DGLIDEN64_BUILD_TYPE=Release -DCMAKE_C_COMPILER="${CC}" -DCMAKE_CXX_COMPILER="${CXX}" -DCMAKE_C_FLAGS="${CFLAGS}" -DCMAKE_CXX_FLAGS="${CXXFLAGS} -pthread" -S src -B projects/cmake
  make -Wno-unused-variable -C projects/cmake
  cp ${PKG_BUILD}/projects/cmake/plugin/Release/mupen64plus-video-GLideN64.so ${PKG_BUILD}/projects/cmake/plugin/Release/mupen64plus-video-GLideN64-simple.so
}

makeinstall_target() {
  UPREFIX=${INSTALL}/usr/local
  ULIBDIR=${UPREFIX}/lib
  USHAREDIR=${UPREFIX}/share/mupen64plus
  UPLUGINDIR=${ULIBDIR}/mupen64plus
  mkdir -p ${UPLUGINDIR}
  cp ${PKG_BUILD}/projects/cmake/plugin/Release/mupen64plus-video-GLideN64-base.so ${UPLUGINDIR}/mupen64plus-video-GLideN64.so
  #${STRIP} ${UPLUGINDIR}/mupen64plus-video-GLideN64.so
  chmod 0644 ${UPLUGINDIR}/mupen64plus-video-GLideN64.so
  cp ${PKG_BUILD}/projects/cmake/plugin/Release/mupen64plus-video-GLideN64-simple.so ${UPLUGINDIR} 
  #${STRIP} ${UPLUGINDIR}/mupen64plus-video-GLideN64-simple.so
  chmod 0644 ${UPLUGINDIR}/mupen64plus-video-GLideN64-simple.so
  mkdir -p ${USHAREDIR}
  cp ${PKG_BUILD}/ini/GLideN64.ini ${USHAREDIR}
  chmod 0644 ${USHAREDIR}/GLideN64.ini
}
