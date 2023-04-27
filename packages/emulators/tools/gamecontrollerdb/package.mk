# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2021-present Fewtarius (https://github.com/fewtarius)

PKG_NAME="gamecontrollerdb"
PKG_VERSION="01cca2e77f9bf9f1432be04f876f287eb78297fe"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_DEPENDS_TARGET="toolchain SDL2"
PKG_SITE="https://github.com/gabomdq/SDL_GameControllerDB"
PKG_URL="${PKG_SITE}.git"
PKG_SECTION="tools"
PKG_SHORTDESC="SDL Game Controller DB"
PKG_TOOLCHAIN="manual"

make_target() {
  :
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/config/SDL-GameControllerDB
  if [ -f "${PKG_DIR}/sources/gamecontrollerdb.txt" ]
  then
    cat ${PKG_DIR}/sources/gamecontrollerdb.txt >${INSTALL}/usr/config/SDL-GameControllerDB/gamecontrollerdb.txt
  fi
  cat ${PKG_BUILD}/gamecontrollerdb.txt >>${INSTALL}/usr/config/SDL-GameControllerDB/gamecontrollerdb.txt
}
