# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="modules"
PKG_VERSION=""
PKG_ARCH="any"
PKG_LICENSE="custom"
PKG_SITE=""
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain rclone"
PKG_SHORTDESC="OS Modules Package"
PKG_LONGDESC="OS Modules Package"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"
PKG_TOOLCHAIN="manual"

###
### Note: Start scripts for emulators have been moved to
### packages/virtual/emulators.
###

make_target() {
  :
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/config/modules
  cp -rf ${PKG_DIR}/sources/* ${INSTALL}/usr/config/modules
  chmod 0755 ${INSTALL}/usr/config/modules/*
}

post_makeinstall_target() {
  case ${ARCH} in
    x86_64)
      rm -f ${INSTALL}/usr/config/modules/*32bit*
      rm -f ${INSTALL}/usr/config/modules/*Master*
    ;;
  esac

  case ${DEVICE} in
    S922X*)
      rm -f ${INSTALL}/usr/config/modules/*ScummVM*
      rm -f ${INSTALL}/usr/config/modules/*32bit*
    ;;
  esac

  if [ ! "${INSTALLER_SUPPORT}" = "yes" ] || \
     [ ! "${DISPLAYSERVER}" = "wl" ]
  then
    rm -f ${INSTALL}/usr/config/modules/Install*
  fi
}

