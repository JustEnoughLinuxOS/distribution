# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="edid-decode"
PKG_VERSION="5f723267e04deb3aa9610483514a02bcee10d9c2" # 2022-09-23
PKG_LICENSE="None"
PKG_SITE="https://git.linuxtv.org/edid-decode.git/"
PKG_URL="https://repo.or.cz/edid-decode.git/snapshot/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Decode EDID data in human-readable format"

EDID_SOURCES="calc-gtf-cvt.cpp calc-ovt.cpp \
              edid-decode.cpp parse-base-block.cpp parse-cta-block.cpp \
              parse-displayid-block.cpp parse-ls-ext-block.cpp \
              parse-di-ext-block.cpp parse-vtb-ext-block.cpp"

make_target() {
  echo "${CXX} ${CPPFLAGS} -Wall ${LDFLAGS} -g -DSHA=${PKG_VERSION:0:12} -o edid-decode ${EDID_SOURCES} -lm"
  ${CXX} ${CPPFLAGS} -Wall ${LDFLAGS} -g -DSHA=${PKG_VERSION:0:12} -o edid-decode ${EDID_SOURCES} -lm
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
    cp edid-decode ${INSTALL}/usr/bin
}
