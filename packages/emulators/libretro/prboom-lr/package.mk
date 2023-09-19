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

PKG_NAME="prboom-lr"
PKG_VERSION="6ec854969fd9dec33bb2cab350f05675d1158969"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/libretro-prboom"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="libretro implementation of Doom"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp prboom_libretro.so ${INSTALL}/usr/lib/libretro/prboom_libretro.so

  mkdir -p ${INSTALL}/usr/config/idtech
  cp -rf ${PKG_DIR}/scripts/* ${INSTALL}/usr/config/idtech/
  chmod 0755 ${INSTALL}/usr/config/idtech/*
}
