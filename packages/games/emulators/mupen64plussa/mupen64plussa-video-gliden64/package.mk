# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="mupen64plussa-video-gliden64"
PKG_VERSION="7a182fbf0f7ca7527cff05e7eec292ca67ab4e48"
PKG_ARCH="aarch64"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/gonetz/GLideN64"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain boost libpng SDL2 SDL2_net zlib freetype nasm:host mupen64plussa-core"
PKG_SHORTDESC="mupen64plus-video-gliden64"
PKG_LONGDESC="Mupen64Plus Standalone GLide64 Video Driver"
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
      # if [ "${DEVICE}" = "RG552" ]
      # then
      #   export USE_GLES=0
      #   PKG_MAKE_OPTS_TARGET+="-DNOHQ=On -DCRC_ARMV8=On -DNEON_OPT=On"
      # else
      export USE_GLES=1
      PKG_MAKE_OPTS_TARGET+="-DNOHQ=On -DCRC_ARMV8=On -DEGL=On -DNEON_OPT=On"
      # fi
    ;;
  esac
  export APIDIR=$(get_build_dir mupen64plussa-core)/.install_pkg/usr/local/include/mupen64plus
  export SDL_CFLAGS="-I${SYSROOT_PREFIX}/usr/include/SDL2 -pthread"
  export SDL_LDLIBS="-lSDL2_net -lSDL2"
  export CROSS_COMPILE="${TARGET_PREFIX}"
  export V=1
  export VC=0
  ./src/getRevision.sh
  cmake ${PKG_MAKE_OPTS_TARGET} -DMUPENPLUSAPI=On -DGLIDEN64_BUILD_TYPE=Release -DCMAKE_C_COMPILER="${CC}" -DCMAKE_CXX_COMPILER="${CXX}" -DCMAKE_C_FLAGS="${CFLAGS}" -DCMAKE_CXX_FLAGS="${CXXFLAGS} -pthread" -S src -B projects/cmake
  make clean -C projects/cmake
  make -Wno-unused-variable -C projects/cmake
}

makeinstall_target() {
  UPREFIX=${INSTALL}/usr/local
  ULIBDIR=${UPREFIX}/lib
  USHAREDIR=${UPREFIX}/share/mupen64plus
  UPLUGINDIR=${ULIBDIR}/mupen64plus
  mkdir -p ${UPLUGINDIR}
  cp ${PKG_BUILD}/projects/cmake/plugin/Release/mupen64plus-video-GLideN64.so ${UPLUGINDIR} 
  #$STRIP ${UPLUGINDIR}/mupen64plus-video-GLideN64.so
  chmod 0644 ${UPLUGINDIR}/mupen64plus-video-GLideN64.so
  mkdir -p ${USHAREDIR}
  cp ${PKG_BUILD}/ini/GLideN64.ini ${USHAREDIR}
  chmod 0644 ${USHAREDIR}/GLideN64.ini
}

