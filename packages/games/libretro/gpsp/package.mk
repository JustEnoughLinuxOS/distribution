################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#      Copyright (C) 2020 351ELEC team (https://github.com/fewtarius/351ELEC)
#      Copyright (C) 2022 Fewtarius
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

PKG_NAME="gpsp"
PKG_VERSION="81649a2c8075201bb823cce8fdf16a31c92a3b6c"
PKG_SHA256="c1131811760dd78cbb8621b5845b4402a0801690facc77d4e8ea1292384bcd1b"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/gpsp"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="gpSP for libretro."
PKG_LONGDESC="gameplaySP is a Gameboy Advance emulator for Playstation Portable"
PKG_PATCH_DIRS+="${DEVICE}"
PKG_IS_ADDON="no"
PKG_TOOLCHAIN="make"
PKG_AUTORECONF="no"

if [ "${ARCH}" = "arm" ]
then
  make_target() {
    if [[ "${DEVICE}" =~ RG351 ]]
    then
      make CC=${CC} platform=RG351x
    elif [[ "${DEVICE}" =~ RG503 ]] || [[ "${DEVICE}" =~ RG353P ]]
    then
      make CC=${CC} platform=RK3566
    else
      make CC=${CC} platform=${DEVICE}
    fi
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
