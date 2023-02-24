# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="gptokeyb"
PKG_VERSION="0303b36b5376a9b25cf82a53ed4242509daf14e9"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/EmuELEC/gptokeyb"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain libevdev SDL2 control-gen"
PKG_TOOLCHAIN="make"
GET_HANDLER_SUPPORT="git"

pre_make_target() {
  cp -f ${PKG_DIR}/Makefile ${PKG_BUILD}
  CFLAGS+=" -I$(get_build_dir SDL2)/include -D_REENTRANT"
  CFLAGS+=" -I$(get_build_dir libevdev)"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp ${PKG_BUILD}/gptokeyb ${INSTALL}/usr/bin
}
