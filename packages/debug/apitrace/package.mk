# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2020-present Fewtarius

PKG_NAME="apitrace"
PKG_VERSION="ff63667f67825f81a2021560db8a1b46d50fc0af"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/apitrace/apitrace"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A set of tools to trace, replay, and inspect OpenGL calls"
GET_HANDLER_SUPPORT="git"

PKG_CMAKE_OPTS_TARGET="-DENABLE_GUI=false -DENABLE_X11=false"
