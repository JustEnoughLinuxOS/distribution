################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#      Copyright (C) 2009-2012 Fewtarius
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

PKG_NAME="atari800"
PKG_VERSION="94033288b026fe699bc50703609807aa8075f4dd"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/libretro-atari800"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="atari800 3.1.0 for libretro/libco WIP"
PKG_LONGDESC="atari800 3.1.0 for libretro/libco WIP"
PKG_TOOLCHAIN="auto"
GET_HANDLER_SUPPORT="git"

if [ "${DEVICE}" = "RG552" ]
then
  PKG_MAKE_OPTS_TARGET="platform=rg552 GIT_VERSION=${PKG_VERSION:0:7}"
fi

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp atari800_libretro.so ${INSTALL}/usr/lib/libretro/
}
