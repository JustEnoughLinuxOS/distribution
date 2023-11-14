# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="fuse"
PKG_VERSION="3.16.2"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libfuse/libfuse/"
PKG_URL="https://github.com/libfuse/libfuse/releases/download/${PKG_NAME}-${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="FUSE provides a simple interface for userspace programs to export a virtual filesystem to the Linux kernel."
# fuse fails to build with GOLD linker on gcc-4.9
PKG_BUILD_FLAGS="-gold"

PKG_MESON_OPTS_TARGET+="-Dudevrulesdir=/usr/lib/udev \
                        -Dinitscriptdir= \
                        -Dtests=false \
                        -Dexamples=false"
                        
post_makeinstall_target() {
  ln -sf fusermount3 ${INSTALL}/usr/bin/fusermount
  ln -sf mount.fuse3 ${INSTALL}/usr/sbin/mount.fuse
}
