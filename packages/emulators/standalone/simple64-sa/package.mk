# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023-present RiShooty (https://github.com/rishooty)

PKG_NAME="simple64-sa"
PKG_VERSION="23107ed09a091b890c008fa71a69fc0a0ccc54cc"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/simple64/simple64"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain qt5"
PKG_LONGDESC="Simple64, a N64 Emulator"
PKG_TOOLCHAIN="manual"

make_target() {
  cd ${PKG_BUILD}
  ./build.sh
}
