# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present 351ELEC (https://github.com/351ELEC)
# Copyright (C) 2022-present Fewtarius

PKG_NAME="raze"
PKG_VERSION="5a27390eaf0bf130df9ff94ff82835c3bbbdaea1"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/zdoom/Raze"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain SDL2 raze:host zmusic libvpx"
PKG_SHORTDESC="Raze is a fork of Build engine games backed by GZDoom tech and combines Duke Nukem 3D, Blood, Redneck Rampage, Shadow Warrior and Exhumed/Powerslave in a single package."
PKG_LONGDESC="Raze is a fork of Build engine games backed by GZDoom tech and combines Duke Nukem 3D, Blood, Redneck Rampage, Shadow Warrior and Exhumed/Powerslave in a single package."
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

pre_configure_host(){
PKG_CMAKE_OPTS_HOST=" -DZMUSIC_LIBRARIES=$(get_build_dir zmusic)/build_host/source/libzmusic.so \
                      -DZMUSIC_INCLUDE_DIR=$(get_build_dir zmusic)/include"
}

pre_configure_target() {
PKG_CMAKE_OPTS_TARGET=" -DNO_GTK=ON \
                        -DFORCE_CROSSCOMPILE=ON \
                        -DIMPORT_EXECUTABLES=${PKG_BUILD}/.${HOST_NAME}/ImportExecutables.cmake \
                        -DCMAKE_BUILD_TYPE=Release \
                        -DHAVE_GLES2=ON \
                        -DHAVE_VULKAN=OFF \
                        -DZMUSIC_LIBRARIES=$(get_build_dir zmusic)/build_target/source/libzmusic.so -DZMUSIC_INCLUDE_DIR=$(get_build_dir zmusic)/include"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp ${PKG_DIR}/sources/start_raze.sh ${INSTALL}/usr/bin/
  cp ${PKG_BUILD}/.${TARGET_NAME}/raze ${INSTALL}/usr/bin
  chmod 0755 ${INSTALL}/usr/bin/*

  mkdir -p ${INSTALL}/usr/config/game/raze
  cp -rf ${PKG_DIR}/config/common/* ${INSTALL}/usr/config/game/raze
  chmod 0755 ${INSTALL}/usr/config/game/raze/games/*sh
  if [ -d "${PKG_DIR}/config/${DEVICE}" ]
  then
    cp -rf ${PKG_DIR}/config/${DEVICE}/* ${INSTALL}/usr/config/game/raze
    cat ${INSTALL}/usr/config/game/raze/defaults.ini >> ${INSTALL}/usr/config/game/raze/raze.ini
    rm ${INSTALL}/usr/config/game/raze/defaults.ini
  fi
  cp ${PKG_BUILD}/.${TARGET_NAME}/*.pk3 ${INSTALL}/usr/config/game/raze
  cp -r ${PKG_BUILD}/.${TARGET_NAME}/soundfonts ${INSTALL}/usr/config/game/raze

  mkdir -p ${INSTALL}/usr/lib/autostart/common
  cp ${PKG_DIR}/sources/autostart/common/* ${INSTALL}/usr/lib/autostart/common
  chmod 0755 ${INSTALL}/usr/lib/autostart/common/*
}
