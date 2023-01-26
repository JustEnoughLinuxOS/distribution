# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="jslisten"
PKG_VERSION="3c84610"
PKG_LICENSE="GPL3"
PKG_SITE="https://github.com/workinghard/jslisten"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="listen to gamepad inputs and trigger a command"
PKG_TOOLCHAIN="make"

make_target() {
  if [ ! -d "bin" ]
  then
    mkdir bin
  fi
  make 
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp bin/jslisten ${INSTALL}/usr/bin
  mkdir -p ${INSTALL}/usr/config
  cp ${PKG_DIR}/config/* ${INSTALL}/usr/config
}
