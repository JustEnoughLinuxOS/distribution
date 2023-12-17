# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023-present JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="qt6"
PKG_MAJOR_VERSION="6.6"
PKG_VERSION="${PKG_MAJOR_VERSION}.1"
PKG_LICENSE="GPLv3"
PKG_SITE="https://download.qt.io"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Qt6 - Qt is a full development framework with tools designed to streamline the creation of applications and user interfaces for desktop, embedded, and mobile platforms."

PKG_DEPENDS_TARGET+=" qt6base qt6tools qt6wayland"
