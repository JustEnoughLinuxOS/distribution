# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Shanti Gilbert (https://github.com/shantigilbert)
# Copyright (C) 2023-present Fewtarius

PKG_NAME="patchelf"
PKG_VERSION="0.18.0"
PKG_LICENSE="OSS"
PKG_SITE="https://github.com/NixOS/patchelf"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python3 distutilscross:host"
PKG_LONGDESC="A small utility to modify the dynamic linker and RPATH of ELF executables"
PKG_TOOLCHAIN="configure"

pre_configure_target() {
./bootstrap.sh
}
