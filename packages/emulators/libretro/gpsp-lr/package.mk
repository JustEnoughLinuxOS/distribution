################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#      Copyright (C) 2020 351ELEC team (https://github.com/fewtarius/351ELEC)
#      Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)
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

PKG_NAME="gpsp-lr"
PKG_VERSION="895fb075c3a04a0eff8c92a150e01e42df10a062"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/gpsp"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="gameplaySP is a Gameboy Advance emulator for Playstation Portable"
PKG_PATCH_DIRS+="${DEVICE}"
PKG_TOOLCHAIN="make"

if [ "${ARCH}" = "arm" ]
then
  make_target() {
      make CC=${CC} platform=${DEVICE}
  }
else
  make_target() {
    :
  }
fi

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  if [ "${ARCH}" = "aarch64" ]
  then
    cp -vP ${ROOT}/build.${DISTRO}-${DEVICE}.arm/gpsp-*/.install_pkg/usr/lib/libretro/gpsp_libretro.so ${INSTALL}/usr/lib/libretro/
  else
    cp ${PKG_BUILD}/gpsp_libretro.so ${INSTALL}/usr/lib/libretro/
  fi
}
