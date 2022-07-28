# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present Shanti Gilbert (https://github.com/shantigilbert)
# Copyright (C) 2021-present Fewtarius

PKG_NAME="ecwolf"
PKG_VERSION="e66f5564b9b382bd8a796b4b21384ac6c1356833"
PKG_LICENSE="GPLv2"
PKG_SITE="https://bitbucket.org/ecwolf/ecwolf"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain SDL2 SDL2_mixer SDL2_net ecwolf:host"
PKG_LONGDESC="ECWolf is a port of the Wolfenstein 3D engine based of Wolf4SDL. It combines the original Wolfenstein 3D engine with the user experience of ZDoom to create the most user and mod author friendly Wolf3D source port."
PKG_TOOLCHAIN="cmake-make"
GET_HANDLER_SUPPORT="git"

pre_patch() {
  find $(echo "${PKG_BUILD}" | cut -f1 -d\ ) -type f -exec dos2unix -q {} \;
}

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
						-DIMPORT_EXECUTABLES=${PKG_BUILD}/.${HOST_NAME}/ImportExecutables.cmake						
						-DCMAKE_BUILD_TYPE=Release"

 cd ${PKG_BUILD}/deps/gdtoa
 $HOST_CC -o rithchk arithchk.c -Wall -Wextra
 ./rithchk > ${PKG_BUILD}/deps/gdtoa/arith.h

 $HOST_CC -o qnan qnan.c -Wall -Wextra
 ./qnan > ${PKG_BUILD}/deps/gdtoa/gd_qnan.h
 cd ${PKG_BUILD}
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp ${PKG_BUILD}/ecwolf ${INSTALL}/usr/bin/
  cp ${PKG_DIR}/sources/start_ecwolf.sh ${INSTALL}/usr/bin/
  chmod 0755 ${INSTALL}/usr/bin/*

  mkdir -p ${INSTALL}/usr/config/game/ecwolf
  cp ${PKG_BUILD}/ecwolf.pk3 ${INSTALL}/usr/config/game/ecwolf/
  cp ${PKG_DIR}/config/* ${INSTALL}/usr/config/game/ecwolf/
}
