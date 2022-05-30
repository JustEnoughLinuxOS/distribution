# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2022-present Fewtarius

PKG_NAME="imagemagick"
PKG_VERSION="4c0b7d2"
PKG_LICENSE="http://www.imagemagick.org/script/license.php"
PKG_SITE="https://github.com/ImageMagick/ImageMagick"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_INIT="toolchain"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Software suite to create, edit, compose, or convert bitmap images"

PKG_CONFIGURE_OPTS_INIT="--disable-openmp \
                         --disable-static \
                         --enable-shared \
                         --with-pango=no \
                         --with-utilities=yes \
                         --with-x=no"


PKG_CONFIGURE_OPTS_TARGET="--disable-openmp \
                           --disable-static \
                           --enable-shared \
                           --with-pango=no \
                           --with-utilities=yes \
                           --with-x=no"

makeinstall_init() {
  make install DESTDIR=${INSTALL} ${PKG_MAKEINSTALL_OPTS_INIT}
  rm ${INSTALL}/usr/bin/*config
}

makeinstall_target() {
  make install DESTDIR=${INSTALL} ${PKG_MAKEINSTALL_OPTS_TARGET}
  rm ${INSTALL}/usr/bin/*config
}
