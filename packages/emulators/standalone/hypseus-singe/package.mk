# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present Shanti Gilbert (https://github.com/shantigilbert)
# Copyright (C) 2022-present Fewtarius

PKG_NAME="hypseus-singe"
PKG_VERSION="88e27c57927f0549419b653404d410fb62112c2c"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL3"
PKG_SITE="https://github.com/DirtBagXon/hypseus-singe"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain SDL2 SDL2_ttf SDL2_image libmpeg2 libogg libvorbis"
PKG_LONGDESC="Hypseus is a fork of Daphne. A program that lets one play the original versions of many laserdisc arcade games on one's PC."
PKG_TOOLCHAIN="cmake"
GET_HANDLER_SUPPORT="git"

PKG_CMAKE_OPTS_TARGET=" ./src"

pre_configure_target() {
  mkdir -p ${INSTALL}/usr/config/game/configs/hypseus
  ln -fs /storage/roms/daphne/roms ${INSTALL}/usr/config/game/configs/hypseus/roms
  ln -fs /usr/share/daphne/sound ${INSTALL}/usr/config/game/configs/hypseus/sound
  ln -fs /usr/share/daphne/fonts ${INSTALL}/usr/config/game/configs/hypseus/fonts
  ln -fs /usr/share/daphne/pics ${INSTALL}/usr/config/game/configs/hypseus/pics
}

post_makeinstall_target() {
  cp -rf ${PKG_BUILD}/doc/hypinput.ini ${INSTALL}/usr/config/game/configs/hypseus/
  ln -fs /storage/.config/game/configs/hypseus/hypinput.ini ${INSTALL}/usr/share/daphne/hypinput.ini
  cp ${PKG_BUILD}/start_hypseus.sh ${INSTALL}/usr/bin
}
