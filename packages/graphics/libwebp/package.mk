# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023-present JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="libwebp"
PKG_VERSION="e78e924f84ddcd41fc5d55583bc32f4ddc4100a3"
PKG_LICENSE="BSD"
PKG_SITE="https://github.com/webmproject/libwebp"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="toolchain:host"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="WebP codec is a library to encode and decode images in WebP format."
PKG_TOOLCHAIN="cmake"
