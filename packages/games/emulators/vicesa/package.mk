# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2020-present Fewtarius

PKG_NAME="vicesa"
PKG_VERSION="3.6.1"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://sourceforge.net/projects/vice-emu"
PKG_URL="${PKG_SITE}/files/releases/vice-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain xa:host SDL2 SDL2_image ncurses readline"
PKG_PRIORITY="optional"
PKG_SECTION="emulators"
PKG_SHORTDESC="Commodore 8-bit Emulator"
PKG_LONGDESC="Commodore 8-bit Emulator"
PKG_CONFIGURE_OPTS_TARGET+="--disable-pdf-docs"

if [ ! "${OPENGL}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} glu libglvnd"
fi

if [ "${OPENGLES_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

pre_configure_target() {
  export LDFLAGS="${LDFLAGS} -lreadline -lncursesw -ltinfow"
  export CFLAGS="${CFLAGS} -fcommon"
}

post_makeinstall_target() {
  mkdir -p ${INSTALL}/usr/config/vice
  if [ -d "${PKG_DIR}/config/${DEVICE}" ]
  then
    cp -f ${PKG_DIR}/config/${DEVICE}/* ${INSTALL}/usr/config/vice
  fi
  cp -f ${PKG_DIR}/sources/* ${INSTALL}/usr/bin
  chmod 0755 ${INSTALL}/usr/bin/*
}
