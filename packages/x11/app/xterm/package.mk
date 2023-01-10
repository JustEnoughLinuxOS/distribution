# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2020-present Fewtarius

PKG_NAME="xterm"
PKG_VERSION="378"
PKG_LICENSE="MIT"
PKG_SITE="http://invisible-mirror.net/archives/xterm"
PKG_URL="${PKG_SITE}/${PKG_NAME}-${PKG_VERSION}.tgz"
PKG_DEPENDS_TARGET="toolchain ncurses xorg-server libXaw libXpm"
PKG_LONGDESC="Terminal emulator for X11."

pre_configure_target() {
  export LDFLAGS="${LDFLAGS} -lreadline -lncursesw -ltinfow"
  export CFLAGS="${CFLAGS} -fcommon"
}
