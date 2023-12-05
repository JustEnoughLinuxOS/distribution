# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present 351ELEC (https://github.com/351ELEC)
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="gzdoom-sa"
PKG_VERSION="d05ea1965ad1f070859806a3a67aaf5ea6c46234"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/ZDoom/gzdoom"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_HOST="toolchain SDL2:host zmusic:host"
PKG_DEPENDS_TARGET="toolchain SDL2 gzdoom-sa:host zmusic"
PKG_LONGDESC="GZDoom is a modder-friendly OpenGL and Vulkan source port based on the DOOM engine"
GET_HANDLER_SUPPORT="git"
PKG_TOOLCHAIN="cmake-make"


pre_configure_host() {
  unset HOST_CMAKE_OPTS
  PKG_CMAKE_OPTS_HOST=" -DZMUSIC_LIBRARIES=${TOOLCHAIN}/usr/lib/libzmusic.so \
                        -DZMUSIC_INCLUDE_DIR=${TOOLCHAIN}/usr/include"
}

make_host() {
  cmake . -DNO_GTK=ON
  make
}

makeinstall_host() {
  :
}

pre_configure_target() {
  PKG_CMAKE_OPTS_TARGET+=" -DNO_GTK=ON \
                           -DFORCE_CROSSCOMPILE=ON \
                           -DIMPORT_EXECUTABLES=${PKG_BUILD}/.${HOST_NAME}/ImportExecutables.cmake \
                           -DCMAKE_BUILD_TYPE=Release \
                           -DZMUSIC_LIBRARIES=${SYSROOT_PREFIX}/usr/lib/libzmusic.so -DZMUSIC_INCLUDE_DIR=${SYSROOT_PREFIX}/usr/include"
}

makeinstall_target() {

  mkdir -p ${INSTALL}/usr/bin
  cp ${PKG_BUILD}/.${TARGET_NAME}/gzdoom ${INSTALL}/usr/bin
  cp ${PKG_DIR}/scripts/start_gzdoom.sh ${INSTALL}/usr/bin/
  chmod +x ${INSTALL}/usr/bin/*

  mkdir -p ${INSTALL}/usr/config/gzdoom
  cp ${PKG_DIR}/config/* ${INSTALL}/usr/config/gzdoom
  cp ${PKG_BUILD}/.${TARGET_NAME}/*.pk3 ${INSTALL}/usr/config/gzdoom
  cp -r ${PKG_BUILD}/.${TARGET_NAME}/soundfonts ${INSTALL}/usr/config/gzdoom
  cp -r ${PKG_BUILD}/.${TARGET_NAME}/fm_banks ${INSTALL}/usr/config/gzdoom
}
