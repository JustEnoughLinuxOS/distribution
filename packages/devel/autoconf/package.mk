# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="autoconf"
PKG_VERSION="2.70"
PKG_SHA256="fa9e227860d9d845c0a07f63b88c8d7a2ae1aa2345fb619384bb8accc19fecc6"
PKG_LICENSE="GPL"
PKG_SITE="http://sources.redhat.com/autoconf/"
PKG_URL="http://ftpmirror.gnu.org/autoconf/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_HOST="ccache:host m4:host gettext:host"
PKG_LONGDESC="A GNU tool for automatically configuring source code."

PKG_CONFIGURE_OPTS_HOST="EMACS=no \
                         ac_cv_path_M4=${TOOLCHAIN}/bin/m4 \
                         ac_cv_prog_gnu_m4_gnu=no \
                         --target=${TARGET_NAME}"

post_makeinstall_host() {
  make prefix=${SYSROOT_PREFIX}/usr install
}
