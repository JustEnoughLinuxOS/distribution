# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)
# Copyright (C) 2020-present Fewtarius

PKG_NAME="scummvmsa"
PKG_VERSION="f23d8fddf7707bc329ae61377116def826c8bcfb"
PKG_SHA256="44caeabf18cf8459fd306cba12c4e0f237a31dc1e40f7e18ecd51247f9f29a9d"
PKG_REV="1"
PKG_LICENSE="GPL2"
PKG_SITE="https://github.com/scummvm/scummvm"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain SDL2 SDL2_net freetype fluidsynth"
PKG_SHORTDESC="Script Creation Utility for Maniac Mansion Virtual Machine"
PKG_LONGDESC="ScummVM is a program which allows you to run certain classic graphical point-and-click adventure games, provided you already have their data files."

pre_configure_target() { 
  sed -i "s|sdl-config|sdl2-config|g" ${PKG_BUILD}/configure
  TARGET_CONFIGURE_OPTS="--host=${TARGET_NAME} --backend=sdl --with-sdl-prefix=${SYSROOT_PREFIX}/usr/bin --disable-debug --enable-release --enable-vkeybd --opengl-mode=gles2"
}

post_makeinstall_target() {
  mkdir -p ${INSTALL}/usr/config/scummvm/
  cp -rf ${PKG_DIR}/config/* ${INSTALL}/usr/config/scummvm/
  chmod 0755 ${INSTALL}/usr/config/scummvm/games/*sh

  mkdir -p ${INSTALL}/usr/config/scummvm/themes
  cp -rf ${PKG_BUILD}/gui/themes ${INSTALL}/usr/config/scummvm/themes

  mv ${INSTALL}/usr/local/bin ${INSTALL}/usr/
  cp -rf ${PKG_DIR}/sources/* ${INSTALL}/usr/bin
  chmod 755 ${INSTALL}/usr/bin/*
	
  for i in appdata applications doc icons man; do
    rm -rf "${INSTALL}/usr/local/share/${i}"
  done
}

