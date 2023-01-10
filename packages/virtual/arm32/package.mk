# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2022 - Fewtarius

PKG_NAME="arm32"
PKG_LICENSE="Apache-2.0"
PKG_SITE="www.jelos.org"
PKG_DEPENDS_TARGET="toolchain squashfs-tools:host dosfstools:host fakeroot:host kmod:host mtools:host populatefs:host libc gcc linux linux-drivers linux-firmware libusb unzip socat p7zip file ${OPENGLES} SDL2 SDL2_gfx SDL2_image SDL2_mixer SDL2_net SDL2_ttf"
PKG_SECTION="virtual"
PKG_LONGDESC="Root package used to build and create 32-bit userland"
