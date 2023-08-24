# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2020-present Fewtarius

PKG_NAME="powertop"
PKG_VERSION="24a96ea894b1e8916664a6aa35f5c77d3167fcf9"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/fenrus75/powertop"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain ncurses libnl pciutils systemd libtracefs"
PKG_LONGDESC="Power consumption / management diagnostic utility."
PKG_BUILD_FLAGS="+pic"
PKG_TOOLCHAIN="autotools"

pre_configure_target() {
  export LDFLAGS="${LDFLAGS} -ludev"
}

