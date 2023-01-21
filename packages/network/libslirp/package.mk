# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="libslirp"
PKG_VERSION="4.6.1"
PKG_SHA256="69ad4df0123742a29cc783b35de34771ed74d085482470df6313b6abeb799b11"
PKG_LICENSE="OSS"
PKG_SITE="https://gitlab.freedesktop.org/slirp/libslirp"
PKG_URL="https://gitlab.freedesktop.org/slirp/libslirp/-/archive/v${PKG_VERSION}/${PKG_NAME}-v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain glib"
PKG_LONGDESC="A general purpose TCP-IP emulator used by virtual machine hypervisors to provide virtual networking services."
