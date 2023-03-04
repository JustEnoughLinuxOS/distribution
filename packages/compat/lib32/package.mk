# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present 351ELEC (https://github.com/351ELEC)

PKG_NAME="lib32"
PKG_VERSION="$(date +%Y%m%d)"
PKG_ARCH="aarch64"
PKG_LICENSE="GPLv2"
PKG_DEPENDS_TARGET="toolchain retroarch SDL2 libsndfile libmodplug"
PKG_SHORTDESC="ARM 32bit bundle for aarch64"
PKG_PRIORITY="optional"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  cd ${PKG_BUILD}
  LIBROOT="${ROOT}/build.${DISTRO}-${DEVICE}.arm/image/system/"
  if [ "${ARCH}" = "aarch64" ]; then
    mkdir -p ${INSTALL}/usr/lib32
    rsync -al ${LIBROOT}/usr/lib/* ${INSTALL}/usr/lib32 >/dev/null 2>&1
    chmod -f +x ${INSTALL}/usr/lib32/* || :
  fi
  mkdir -p ${INSTALL}/usr/lib
  ln -s /usr/lib32/ld-linux-armhf.so.3 ${INSTALL}/usr/lib/ld-linux-armhf.so.3

  mkdir -p "${INSTALL}/etc/ld.so.conf.d"
  echo "/usr/lib32" > "${INSTALL}/etc/ld.so.conf.d/arm-lib32.conf"
  echo "/usr/lib32/pulseaudio" >"${INSTALL}/etc/ld.so.conf.d/arm-lib32-pulseaudio.conf"
  if [ -d "${LIBROOT}/usr/lib/dri" ]
  then
    echo "/usr/lib32/dri" >"${INSTALL}/etc/ld.so.conf.d/arm-lib32-dri.conf"
  fi
  if [ -d "${LIBROOT}/usr/lib/gl4es" ]
  then
     echo "/usr/lib/gl4es" >"${INSTALL}/etc/ld.so.conf.d/arm-lib32-gl4es.conf"
  fi
}
