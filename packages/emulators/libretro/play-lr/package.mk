# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present - The JELOS Project (https://github.com/JustEnoughLinuxOS)

PKG_NAME="play-lr"
PKG_VERSION="e0f5091e6eb80d609807fc2a9da3f2516373582f"
PKG_ARCH="x86_64"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/jpd002/Play-"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain libevdev zstd"
PKG_LONGDESC="Play! is an attempt to create a PlayStation 2 emulator for Windows, macOS, UNIX, Android & iOS platforms."
PKG_TOOLCHAIN="cmake"

PKG_CMAKE_OPTS_TARGET="-DBUILD_LIBRETRO_CORE=yes \
                       -DBUILD_PLAY=off \
                       -DBUILD_TESTS=no \
                       -DENABLE_AMAZON_S3=no \
                       -DUSE_GLEW=no \
                       -DCMAKE_BUILD_TYPE=Release"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} glu"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

if [ "${OPENGL_SUPPORT}" = "no" -a "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_CMAKE_OPTS_TARGET+=" -DUSE_GLES=yes"
fi

pre_make_target() {
  find ${PKG_BUILD} -name flags.make -exec sed -i "s:isystem :I:g" \{} \;
  find ${PKG_BUILD} -name build.ninja -exec sed -i "s:isystem :I:g" \{} \;
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
     cp ${PKG_BUILD}/.${TARGET_NAME}/Source/ui_libretro/play_libretro.so ${INSTALL}/usr/lib/libretro/
}
