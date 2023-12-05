# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023-present - The JELOS Project (https://github.com/JustEnoughLinuxOS)

PKG_NAME="libwebp"
PKG_VERSION="89c5b917463c07bfb5b6390b81d258c49d5fe8c6"
PKG_LICENSE="BSD"
PKG_SITE="https://github.com/webmproject/libwebp"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="toolchain:host"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="WebP codec is a library to encode and decode images in WebP format."
PKG_TOOLCHAIN="cmake"
