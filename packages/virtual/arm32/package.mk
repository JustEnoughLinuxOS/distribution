# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2022 - Fewtarius

PKG_NAME="arm32"
PKG_LICENSE="GPL"
PKG_SITE="www.jelos.org"
PKG_DEPENDS_TARGET="toolchain squashfs-tools:host dosfstools:host fakeroot:host kmod:host mtools:host populatefs:host libc gcc linux linux-drivers linux-firmware libusb unzip socat p7zip file ${OPENGLES} SDL2 SDL2_gfx SDL2_image SDL2_mixer SDL2_net SDL2_ttf libgo2 retroarch parallel-n64_rice parallel-n64_gln64 parallel-n64_glide64 gpsp"
PKG_SECTION="virtual"
PKG_LONGDESC="Root package used to build and create 32-bit userland"
