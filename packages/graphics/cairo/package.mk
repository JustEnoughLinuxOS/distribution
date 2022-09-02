# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="cairo"
PKG_VERSION="1.17.4"
PKG_LICENSE="LGPL"
PKG_SITE="http://cairographics.org/"
PKG_URL="https://www.cairographics.org/snapshots/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain zlib freetype fontconfig glib libpng pixman"
PKG_LONGDESC="Cairo is a vector graphics library with cross-device output support."
PKG_TOOLCHAIN="configure" # ToDo

if [ "$OPENGL" != "no" ]; then
  PKG_DEPENDS_TARGET+=" $OPENGL"
fi

if [ "$OPENGLES" != "no" ]; then
  PKG_DEPENDS_TARGET+=" $OPENGLES"
fi

if [ "$DISPLAYSERVER" = "x11" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libXrender libX11 mesa"
  PKG_CAIRO_CONFIG="--x-includes="$SYSROOT_PREFIX/usr/include" \
                    --x-libraries="$SYSROOT_PREFIX/usr/lib" \
                    --enable-xlib \
                    --enable-xlib-xrender \
                    --enable-gl \
                    --enable-glx \
                    --disable-glesv2 \
                    --disable-egl \
                    --with-x"

elif [ "$DISPLAYSERVER" = "wl" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET mesa libglvnd libXrender libX11"
  PKG_CAIRO_CONFIG="--x-includes="$SYSROOT_PREFIX/usr/include" \
                    --x-libraries="$SYSROOT_PREFIX/usr/lib" \
                    --enable-xlib \
                    --enable-xlib-xrender \
                    --disable-gl \
                    --disable-glx \
                    --enable-glesv2 \
                    --enable-egl \
                    --enable-xcb \
                    --enable-xlib-xcb \
                    --enable-xcb-shm \
                    --with-x"
else
  PKG_CAIRO_CONFIG="--disable-xlib \
                    --disable-xlib-xrender \
                    --disable-gl \
                    --disable-glx \
                    --disable-glesv2 \
                    --disable-egl \
                    --disable-xcb \
                    --disable-xlib-xcb \
                    --disable-xcb-shm \
                    --without-x"
fi

PKG_CONFIGURE_OPTS_TARGET="$PKG_CAIRO_CONFIG \
                           --disable-silent-rules \
                           --enable-shared \
                           --disable-static \
                           --disable-gtk-doc \
                           --enable-largefile \
                           --enable-atomic \
                           --disable-gcov \
                           --disable-valgrind \
                           --disable-qt \
                           --disable-quartz \
                           --disable-quartz-font \
                           --disable-quartz-image \
                           --disable-win32 \
                           --disable-win32-font \
                           --disable-skia \
                           --disable-os2 \
                           --disable-beos \
                           --disable-cogl \
                           --disable-drm \
                           --disable-gallium \
                           --enable-png \
                           --disable-directfb \
                           --disable-vg \
                           --disable-wgl \
                           --disable-script \
                           --enable-ft \
                           --enable-fc \
                           --enable-ps \
                           --enable-pdf \
                           --enable-svg \
                           --disable-test-surfaces \
                           --disable-tee \
                           --disable-xml \
                           --enable-pthread \
                           --enable-gobject=yes \
                           --disable-full-testing \
                           --disable-trace \
                           --enable-interpreter \
                           --disable-symbol-lookup \
                           --enable-some-floating-point \
                           --with-gnu-ld"
