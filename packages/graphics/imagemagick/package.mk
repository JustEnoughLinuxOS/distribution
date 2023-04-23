# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2022-present Fewtarius

PKG_NAME="imagemagick"
PKG_VERSION="920f792"
PKG_LICENSE="http://www.imagemagick.org/script/license.php"
PKG_SITE="https://github.com/ImageMagick/ImageMagick"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain libpng librsvg libjpeg-turbo fontconfig libraw lcms2 libtool libxml2 libzip"
PKG_LONGDESC="Software suite to create, edit, compose, or convert bitmap images"

PKG_CONFIGURE_OPTS_TARGET="--disable-openmp \
                           --enable-static \
                           --disable-shared \
                           --with-pango=no \
                           --with-utilities=yes \
                           --with-x=no"

if [ "${DISPLAYSERVER}" = "wl" ]; then
  PKG_DEPENDS_TARGET+=" libXext pango" 
  PKG_CONFIGURE_OPTS_TARGET+=" --with-x=yes"
else
  PKG_CONFIGURE_OPTS_TARGET+=" --with-x=no"
fi

makeinstall_target() {
  make install DESTDIR=${INSTALL} ${PKG_MAKEINSTALL_OPTS_TARGET}
  rm ${INSTALL}/usr/bin/*config
}
