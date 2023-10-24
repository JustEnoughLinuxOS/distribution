# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present - The JELOS Project (https://github.com/JustEnoughLinuxOS) (https://github.com/brooksytech)

PKG_NAME="libdatrie"
PKG_VERSION="0.2.13"
PKG_LICENSE="LGPLv2"
PKG_SITE="https://github.com/tlwg/libdatrie"
PKG_URL="${PKG_SITE}/releases/download/v${PKG_VERSION}/libdatrie-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain libtool"
PKG_BUILD_FLAGS="+pic"
PKG_TOOLCHAIN="configure"

