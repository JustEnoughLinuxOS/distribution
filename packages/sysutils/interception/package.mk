# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="interception"
PKG_VERSION="0.6.8"
PKG_SHA256="45527d9430c2d29f9dce9403d2f8d76f393fe156c8736d618166388169d4268d"
PKG_LICENSE="GPLv3"
PKG_SITE="https://gitlab.com/interception/linux/tools"
PKG_URL="https://gitlab.com/interception/linux/tools/-/archive/v${PKG_VERSION}/tools-v${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="boost yaml-cpp"
PKG_TOOLCHAIN="cmake"
PKG_LONGDESC="A minimal composable infrastructure on top of libudev and libevdev."

PKG_CMAKE_OPTS_COMMON="-DCMAKE_BUILD_TYPE=Release"
