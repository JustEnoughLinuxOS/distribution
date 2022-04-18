# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="lzdoom"
PKG_VERSION="2ee3ea91bc9c052b3143f44c96d85df22851426f"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/351ELEC/lzdoom"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain SDL2 lzdoom:host"
PKG_SHORTDESC="LZDoom"
PKG_LONGDESC="ZDoom is a family of enhanced ports of the Doom engine for running on modern operating systems. It runs on Windows, Linux, and OS X, and adds new features not found in the games as originally published by id Software."
GET_HANDLER_SUPPORT="git"
PKG_TOOLCHAIN="cmake-make"

PKG_PATCH_DIRS+="${DEVICE}"

pre_build_host() {
  HOST_CMAKE_OPTS=""
}

make_host() {
  cmake . -DNO_GTK=ON
  make
}

makeinstall_host() {
: #no
}

pre_configure_target() {
PKG_CMAKE_OPTS_TARGET=" -DNO_GTK=ON \
                        -DFORCE_CROSSCOMPILE=ON \
                        -DIMPORT_EXECUTABLES=${PKG_BUILD}/.$HOST_NAME/ImportExecutables.cmake \
                        -DCMAKE_BUILD_TYPE=Release"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp ${PKG_DIR}/sources/start_lzdoom.sh ${INSTALL}/usr/bin/
  cp ${PKG_BUILD}/.$TARGET_NAME/lzdoom ${INSTALL}/usr/bin
  chmod 0755 ${INSTALL}/usr/bin/*

  mkdir -p ${INSTALL}/usr/config/game/lzdoom
  if [ -d "${PKG_DIR}/config/${DEVICE}" ]
  then
    cp ${PKG_DIR}/config/${DEVICE}/* ${INSTALL}/usr/config/game/lzdoom
  fi
  cp ${PKG_BUILD}/.$TARGET_NAME/*.pk3 ${INSTALL}/usr/config/game/lzdoom
  cp -r ${PKG_BUILD}/.$TARGET_NAME/soundfonts ${INSTALL}/usr/config/game/lzdoom
  cp -r ${PKG_BUILD}/.$TARGET_NAME/fm_banks ${INSTALL}/usr/config/game/lzdoom
}
