# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="evtest"
PKG_VERSION="ab140a2dab1547f7deb5233be6d94a388cf08b26"
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
