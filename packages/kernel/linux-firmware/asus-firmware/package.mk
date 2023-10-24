# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2023-present - The JELOS Project (https://github.com/JustEnoughLinuxOS)

PKG_NAME="asus-firmware"
PKG_VERSION="b7d9e3ed9cc14dbc5f1640309ae13dd627fc173a"
PKG_LICENSE="https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/LICENSE.cirrus" # Probably
PKG_SITE="https://gitlab.com/asus-linux/firmware"
PKG_URL="${PKG_SITE}.git"
PKG_LONGDESC="ASUS ROG Ally audio firmware"
PKG_DEPENDS_TARGET="linux"
PKG_TOOLCHAIN="manual"

make_target() {
  : 
}

makeinstall_target() {
  mkdir -p ${INSTALL}/$(get_full_firmware_dir)/cirrus ||:
  rsync -a cirrus/* ${INSTALL}/$(get_full_firmware_dir)/cirrus/
}

