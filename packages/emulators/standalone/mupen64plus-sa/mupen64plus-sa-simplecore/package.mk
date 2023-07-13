# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="mupen64plus-sa-simplecore"
PKG_VERSION="89ab4c78354abd921f19fdb99d6d815ac2f8263e"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/simple64/mupen64plus-core"
PKG_URL="https://github.com/simple64/mupen64plus-core/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain boost libpng SDL2 SDL2_net zlib freetype nasm:host mupen64plus-sa-core"
PKG_SHORTDESC="simple64"
PKG_LONGDESC="Simple64's core"
PKG_TOOLCHAIN="manual"
PKG_GIT_CLONE_BRANCH="simple64"

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
      sed -i 's/x86-64-v3/armv8-a/g' ${PKG_BUILD}/CMakeLists.txt
      ARM="-DARM=1"
    ;;
    x86_64)
      export HOST_CPU=x86_64
      ARM=""
    ;;
  esac
  export NEW_DYNAREC=1
  export SDL_CFLAGS="-I${SYSROOT_PREFIX}/usr/include/SDL2 -pthread"
  export SDL_LDLIBS="-lSDL2_net -lSDL2"
  export CROSS_COMPILE="${TARGET_PREFIX}"
  cd ${PKG_BUILD}
  rm -rf build
  mkdir build
  cd build
  cmake -G Ninja ${ARM} -DCMAKE_BUILD_TYPE="Release" ..
  VERBOSE=1 cmake --build .
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/local/lib
  cp ${PKG_BUILD}/build/libmupen64plus.so ${INSTALL}/usr/local/lib/libsimple64.so.2
  chmod 644 ${INSTALL}/usr/local/lib/libsimple64.so.2
  mkdir -p ${SYSROOT_PREFIX}/usr/local/include/simple64
  cp -r ${PKG_BUILD}/src ${SYSROOT_PREFIX}/usr/local/include/simple64/
  find ${PKG_BUILD}/src -name "*.h" -exec cp \{} ${SYSROOT_PREFIX}/usr/local/include/simple64/src \;
}