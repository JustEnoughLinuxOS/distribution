# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023-present Fewtarius

PKG_NAME="gmu"
PKG_VERSION="cf21c3f"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/jhe2/gmu"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain SDL2 opus mpg123 libvorbis flac speex"
PKG_LONGDESC="The Gmu Music Player"
PKG_TOOLCHAIN="configure"

configure_target() {
  export LDFLAGS="${LDFLAGS} -lreadline -lncursesw -ltinfow"
  export TARGET_CFLAGS="${TARGET_CFLAGS} -fcommon"
  export SDL2CONFIG=${SYSROOT_PREFIX}/usr/bin/sdl2-config
  cd ${PKG_BUILD}
  ./configure --enable=medialib
}


make_target() {
  make
}

post_makeinstall_target() {
  mkdir -p ${INSTALL}/usr/config/gmu
  cp -f ${PKG_DIR}/config/gmu.conf ${INSTALL}/usr/config/gmu

  mkdir -p ${INSTALL}/usr/bin
  cp -f ${PKG_DIR}/scripts/start_gmu.sh ${INSTALL}/usr/bin
  chmod +x ${INSTALL}/usr/bin/start_gmu.sh
}
