# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="ncurses"
PKG_VERSION="6.4"
PKG_LICENSE="MIT"
PKG_SITE="http://www.gnu.org/software/ncurses/"
PKG_URL="http://invisible-mirror.net/archives/ncurses/ncurses-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="ccache:host"
PKG_DEPENDS_TARGET="toolchain zlib ncurses:host"
PKG_LONGDESC="A library is a free software emulation of curses in System V Release 4.0, and more."
PKG_BUILD_FLAGS="+pic +pic:host"
PKG_TOOLCHAIN="auto"

PKG_CONFIGURE_OPTS_TARGET="
                           --without-ada \
                           --without-cxx \
                           --without-cxx-binding \
                           --disable-db-install \
                           --without-manpages \
                           --without-progs \
                           --without-tests \
                           --with-shared \
                           --with-normal \
                           --without-debug \
                           --without-profile \
                           --with-termlib \
                           --without-ticlib \
                           --without-gpm \
                           --without-dbmalloc \
                           --without-dmalloc \
                           --disable-rpath \
                           --disable-database \
                           --with-fallbacks=linux,screen,xterm,xterm-color,dumb,st-256color \
                           --with-termpath=/storage/.config/termcap \
                           --disable-big-core \
                           --enable-termcap \
                           --enable-getcap \
                           --disable-getcap-cache \
                           --enable-symlinks \
                           --disable-bsdpad \
                           --without-rcs-ids \
                           --enable-ext-funcs \
                           --disable-const \
                           --enable-no-padding \
                           --disable-sigwinch \
                           --enable-pc-files \
                           --with-pkg-config-libdir=/usr/lib/pkgconfig \
                           --enable-tcap-names \
                           --without-develop \
                           --disable-hard-tabs \
                           --disable-xmc-glitch \
                           --disable-hashmap \
                           --disable-safe-sprintf \
                           --disable-scroll-hints \
                           --enable-widec \
                           --disable-echo \
                           --disable-warnings \
                           --enable-home-terminfo \
                           --enable-lib-suffixes \
                           --disable-assertions"

PKG_CONFIGURE_OPTS_HOST="--enable-termcap \
                         --with-termlib \
                         --without-shared \
                         --enable-pc-files \
                         --without-tests \
                         --without-manpages"

post_makeinstall_target() {
  local f
  cp misc/ncurses-config ${TOOLCHAIN}/bin
  chmod +x ${TOOLCHAIN}/bin/ncurses-config
  sed -e "s:\(['=\" ]\)/usr:\\1${PKG_ORIG_SYSROOT_PREFIX}/usr:g" -i ${TOOLCHAIN}/bin/ncurses-config
  rm -f ${TOOLCHAIN}/bin/ncurses6-config
  rm -rf ${INSTALL}/usr/bin
  # create links to be compatible with any ncurses include path and lib names
  ln -sf . ${SYSROOT_PREFIX}/usr/include/ncursesw
  ln -sf . ${SYSROOT_PREFIX}/usr/include/ncurses
  for f in form menu ncurses panel tinfo; do
    ln -sf lib${f}w.a ${SYSROOT_PREFIX}/usr/lib/lib${f}.a
    ln -sf ${f}w.pc ${SYSROOT_PREFIX}/usr/lib/pkgconfig/${f}.pc
  done
  cd ${INSTALL}/usr/lib
  for LIB in *w*.so*
  do
    NOWLIB=$(echo ${LIB} | sed "s#w##g")
    ln -sf ${LIB} ${INSTALL}/usr/lib/${NOWLIB}
  done
  cd -
}
