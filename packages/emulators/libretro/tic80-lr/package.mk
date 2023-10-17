################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#      Copyright (C) 2020 Fewtarius
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

PKG_NAME="tic80-lr"
PKG_VERSION="f740bff14921fe2120486c8a233094602032b996"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/nesbox/TIC-80"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_HOST="toolchain"
PKG_DEPENDS_TARGET="toolchain tic80-lr:host"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="Tic80"
PKG_LONGDESC="TIC-80 emulator"
GET_HANDLER_SUPPORT="git"
PKG_BUILD_FLAGS="+pic"

pre_configure_host() {
  PKG_CMAKE_OPTS_HOST="-DBUILD_PLAYER=OFF \
                       -DBUILD_SOKOL=OFF \
                       -DBUILD_WITH_JANET=ON \
                       -DBUILD_SDL=OFF \
                       -DBUILD_TOUCH_INPUT=OFF \
                       -DBUILD_DEMO_CARTS=OFF \
                       -DBUILD_LIBRETRO=OFF \
                       -DBUILD_WITH_MRUBY=OFF \
                       -DCMAKE_BUILD_TYPE=Release"
}

pre_configure_target() {
  PKG_CMAKE_OPTS_TARGET="-DBUILD_PLAYER=ON \
                       -DBUILD_SOKOL=OFF \
                       -DBUILD_SDL=OFF \
                       -DBUILD_TOUCH_INPUT=ON \
                       -DBUILD_DEMO_CARTS=OFF \
                       -DBUILD_LIBRETRO=ON \
		       -DBUILD_WITH_MRUBY=OFF \
		       -DCMAKE_BUILD_TYPE=Release"
}

pre_make_host() {
  ### Work around a bug.
  sed -i 's~export.h~../src/export.h~g' ${PKG_BUILD}/vendor/pocketpy/c_bindings/pocketpy_c.h
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp ${PKG_BUILD}/.${TARGET_NAME}/lib/tic80_libretro.so ${INSTALL}/usr/lib/libretro/tic80_libretro.so
}
