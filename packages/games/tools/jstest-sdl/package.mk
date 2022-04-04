# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present Shanti Gilbert (https://github.com/shantigilbert)
# Copyright (C) 2022-present Fewtarius

PKG_NAME="jstest-sdl"
PKG_VERSION="f4fdf6d"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/JustEnoughLinuxOS/jstest-sdl"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain SDL2 ncurses"
PKG_SHORTDESC="Simple SDL joystick test application for the console"
PKG_TOOLCHAIN="make"
GET_HANDLER_SUPPORT="git"

pre_configure_target() {
  sed -i "s|sdl2-config|${SYSROOT_PREFIX}/usr/bin/sdl2-config|g" Makefile
}

makeinstall_target(){
  mkdir -p ${INSTALL}/usr/bin
  cp jstest-sdl ${INSTALL}/usr/bin
}
