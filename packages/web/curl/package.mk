# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="curl"
PKG_VERSION="8.4.0"
PKG_LICENSE="MIT"
PKG_SITE="https://curl.haxx.se"
PKG_URL="https://curl.haxx.se/download/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain zlib openssl rtmpdump libidn2 nghttp2"
PKG_LONGDESC="Client and library for (HTTP, HTTPS, FTP, ...) transfers."
PKG_TOOLCHAIN="configure"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_lib_rtmp_RTMP_Init=yes \
                           ac_cv_header_librtmp_rtmp_h=yes \
                           --disable-debug \
                           --enable-optimize \
                           --enable-warnings \
                           --disable-curldebug \
                           --disable-ares \
                           --enable-largefile \
                           --enable-http \
                           --enable-ftp \
                           --enable-file \
                           --disable-ldap \
                           --disable-ldaps \
                           --enable-rtsp \
                           --enable-proxy \
                           --disable-dict \
                           --disable-telnet \
                           --disable-tftp \
                           --disable-pop3 \
                           --disable-imap \
                           --disable-smb \
                           --disable-smtp \
                           --disable-gopher \
                           --disable-mqtt \
                           --disable-manual \
                           --enable-libgcc \
                           --enable-ipv6 \
                           --enable-versioned-symbols \
                           --enable-nonblocking \
                           --enable-threaded-resolver \
                           --enable-verbose \
                           --disable-sspi \
                           --enable-crypto-auth \
                           --enable-cookies \
                           --enable-symbol-hiding \
                           --disable-soname-bump \
                           --with-gnu-ld \
                           --without-krb4 \
                           --without-spnego \
                           --without-gssapi \
                           --with-zlib \
                           --without-brotli \
                           --without-zstd \
                           --without-egd-socket \
                           --enable-thread \
                           --with-random=/dev/urandom \
                           --without-gnutls \
                           --with-ssl \
                           --without-mbedtls \
                           --without-nss \
                           --with-ca-bundle=/run/libreelec/cacert.pem \
                           --without-ca-path \
                           --without-libpsl \
                           --without-libssh2 \
                           --with-librtmp \
                           --with-libidn2 \
                           --with-nghttp2"

post_makeinstall_target() {
  rm -rf ${INSTALL}/usr/share/zsh

  rm -rf ${INSTALL}/usr/bin/${PKG_NAME}-config
  cp ${PKG_NAME}-config ${TOOLCHAIN}/bin
  sed -e "s:\(['= ]\)/usr:\\1${PKG_ORIG_SYSROOT_PREFIX}/usr:g" -i ${TOOLCHAIN}/bin/${PKG_NAME}-config
  chmod +x ${TOOLCHAIN}/bin/${PKG_NAME}-config
}
