# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="evtest"
PKG_VERSION="da347a8f88d2e5729dd12d61ee9743f902065b55"
PKG_LICENSE="GPL"
PKG_URL="https://gitlab.freedesktop.org/libevdev/evtest.git"
PKG_DEPENDS_TARGET="toolchain libxml2"
PKG_LONGDESC="A simple tool for input event debugging."
PKG_TOOLCHAIN="autotools"
GET_HANDLER_SUPPORT="git"
PKG_GIT_CLONE_BRANCH="master"

#makeinstall_target() {
#  : # nop
#}
