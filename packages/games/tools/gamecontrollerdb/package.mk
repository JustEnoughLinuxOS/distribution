# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2021-present Fewtarius (https://github.com/fewtarius)

PKG_NAME="gamecontrollerdb"
PKG_VERSION="b681748d6dbf2f735f94bd798b8e42042f211f56"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_DEPENDS_TARGET="toolchain SDL2"
PKG_SITE="https://github.com/JustEnoughLinuxOS/SDL_GameControllerDB"
PKG_URL="${PKG_SITE}.git"
PKG_SECTION="tools"
PKG_SHORTDESC="SDL Game Controller DB"
PKG_TOOLCHAIN="manual"

make_target() {
  :
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/config/SDL-GameControllerDB
  if [ -d "${PKG_DIR}/sources/${DEVICE}" ]
  then
    cat ${PKG_DIR}/sources/${DEVICE}/gamecontrollerdb.txt >${INSTALL}/usr/config/SDL-GameControllerDB/gamecontrollerdb.txt
  fi
  cat ${PKG_BUILD}/gamecontrollerdb.txt >>${INSTALL}/usr/config/SDL-GameControllerDB/gamecontrollerdb.txt
}
