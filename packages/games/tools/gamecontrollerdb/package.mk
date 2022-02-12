# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2021-present Fewtarius (https://github.com/fewtarius)

PKG_NAME="gamecontrollerdb"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_DEPENDS_TARGET="toolchain SDL2"
PKG_SECTION="tools"
PKG_SHORTDESC="SDL Game Controller DB"
PKG_TOOLCHAIN="manual"

make_target() {
  echo
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/config/SDL-GameControllerDB
  if [ -d "${PKG_DIR}/sources/${DEVICE}" ]
  then
    cat ${PKG_DIR}/sources/${DEVICE}/gamecontrollerdb.txt >${INSTALL}/usr/config/SDL-GameControllerDB/gamecontrollerdb.txt
  fi
  cat ${PKG_DIR}/sources/gamecontrollerdb.txt >>${INSTALL}/usr/config/SDL-GameControllerDB/gamecontrollerdb.txt
}
