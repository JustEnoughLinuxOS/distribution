################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

PKG_NAME="ppsspp"
PKG_VERSION="317ecdaad1ec9768b3ad234bb8b35c186b7e2916"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/hrydgard/ppsspp"
PKG_URL="https://github.com/hrydgard/ppsspp.git"
PKG_DEPENDS_TARGET="toolchain SDL2 ffmpeg libzip"
PKG_LONGDESC="A PSP emulator for Android, Windows, Mac, Linux and Blackberry 10, written in C++."
GET_HANDLER_SUPPORT="git"
PKG_GIT_CLONE_DEPTH="1"
PKG_GIT_SUBMODULE_DEPTH="1"

PKG_LIBNAME="ppsspp_libretro.so"
PKG_LIBPATH="lib/$PKG_LIBNAME"

pre_configure_target() {
  git submodule update --init --recursive
  PKG_CMAKE_OPTS_TARGET="-DLIBRETRO=ON \
                         -DUSE_SYSTEM_FFMPEG=ON \
                         -DUSING_X11_VULKAN=OFF"

  if [ "${ARCH}" = "arm" ] && [ ! "${TARGET_CPU}" = "arm1176jzf-s" ]; then
    PKG_CMAKE_OPTS_TARGET+=" -DARMV7=ON"
  elif [ "${TARGET_CPU}" = "arm1176jzf-s" ]; then
    PKG_CMAKE_OPTS_TARGET+=" -DARM=ON"
  fi

  if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
    PKG_CMAKE_OPTS_TARGET+=" -DUSING_FBDEV=ON \
                             -DUSING_EGL=ON \
                             -DUSING_GLES2=ON"
  fi
}

pre_make_target() {
  # fix cross compiling
  find $PKG_BUILD -name flags.make -exec sed -i "s:isystem :I:g" \{} \;
  find $PKG_BUILD -name build.ninja -exec sed -i "s:isystem :I:g" \{} \;
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp $PKG_LIBPATH $INSTALL/usr/lib/libretro/
}
