################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#      Copyright (C) 2022-present Fewtarius
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

PKG_NAME="core-info"
PKG_VERSION="8f74759a814bdd05c4abf9f3b4e8e6cabb5d3b57"
PKG_SHA256="870647a5ac56f16355b90305c50aaca5ce7b7cb2fc5fcb4f9e91733e956d0e3b"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/libretro-core-info"
PKG_URL="https://github.com/libretro/libretro-core-info/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Mirror of libretro's core info files"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  rename.ul -v mednafen beetle ${PKG_BUILD}/*.info
  cp ${PKG_BUILD}/*.info ${INSTALL}/usr/lib/libretro/
  cp ${PKG_BUILD}/pcsx_rearmed_libretro.info ${INSTALL}/usr/lib/libretro/pcsx_rearmed32_libretro.info
  cp ${PKG_BUILD}/flycast_libretro.info ${INSTALL}/usr/lib/libretro/flycast_libretro_libretro.info
  cp ${PKG_BUILD}/flycast_libretro.info ${INSTALL}/usr/lib/libretro/flycast32_libretro.info
  cp ${PKG_BUILD}/duckstation_libretro.info ${INSTALL}/usr/lib/libretro/duckstation_custom_libretro.info
}
