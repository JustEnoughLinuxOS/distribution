# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="apitrace"
PKG_VERSION="c314a74227d658db08077d685a83e1246e0c13a7"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/apitrace/apitrace"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A set of tools to trace, replay, and inspect OpenGL calls"
GET_HANDLER_SUPPORT="git"

PKG_CMAKE_OPTS_TARGET="-DENABLE_GUI=false -DENABLE_X11=false"
