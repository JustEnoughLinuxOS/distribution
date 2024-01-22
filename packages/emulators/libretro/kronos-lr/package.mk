# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="kronos-lr"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/yabause"
PKG_ARCH="x86_64"
PKG_URL="${PKG_SITE}.git"
PKG_VERSION="3646a3fc9e414d9474b7a21a39bc2734bb805932"
PKG_GIT_CLONE_BRANCH="kronos"
PKG_DEPENDS_TARGET="toolchain boost zlib"
PKG_LONGDESC="Kronos is a Sega Saturn emulator forked from yabause."
PKG_TOOLCHAIN="make"
GET_HANDLER_SUPPORT="git"
PKG_PATCH_DIRS+="${DEVICE}"

pre_configure_target() {
  sed -i 's/\-latomic//' ${PKG_BUILD}/yabause/src/libretro/Makefile
}

make_target() {
# This was only necessary in the main repo, but may come to libretro later on
#  make -C ${PKG_BUILD}/yabause/src/libretro/ generate-files
  make -C ${PKG_BUILD}/yabause/src/libretro/
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp -a ${PKG_BUILD}/yabause/src/libretro/kronos_libretro.so ${INSTALL}/usr/lib/libretro/kronos_libretro.so
}
