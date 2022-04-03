# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2022-present Fewtarius

PKG_NAME="fuse"
PKG_VERSION="f0bba7e"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libfuse/libfuse"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="FUSE provides a simple interface for userspace programs to export a virtual filesystem to the Linux kernel."
# fuse fails to build with GOLD linker on gcc-4.9
#PKG_BUILD_FLAGS="-gold"

PKG_CONFIGURE_OPTS_TARGET="MOUNT_FUSE_PATH=/usr/sbin \
                           --enable-lib \
                           --enable-util \
                           --disable-example \
                           --enable-mtab \
                           --disable-rpath \
                           --with-gnu-ld"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/{lib,bin}
  cp lib/* ${INSTALL}/usr/lib 2>/dev/null ||:
  cp util/* ${INSTALL}/usr/bin 2>/dev/null ||:
  ln -s fusermount3 ${INSTALL}/usr/bin/fusermount
  ln -s mount.fuse3 ${INSTALL}/usr/bin/mount.fuse
}
