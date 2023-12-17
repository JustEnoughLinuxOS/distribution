# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="powertop"
PKG_VERSION="4bdfba189864d699621708fea182db292edc9305"
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

