# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2023-present - The JELOS Project (https://github.com/JustEnoughLinuxOS)

PKG_NAME="libusb"
PKG_VERSION="6bf2db6"
PKG_LICENSE="LGPLv2.1"
PKG_SITE="https://github.com/libusb/libusb"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain systemd"
PKG_LONGDESC="The libusb project's aim is to create a Library for use by user level applications to USB devices."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--enable-shared \
            --enable-static \
            --disable-log \
            --disable-debug-log \
            --enable-udev \
            --disable-examples-build"
