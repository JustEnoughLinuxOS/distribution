# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="aic8800-firmware"
PKG_LICENSE="Mixed"
PKG_URL="https://github.com/Joshua-Riek/firmware.git"
PKG_LONGDESC="aic8800-firmware: firmware for AIC880 WIFI chip"
PKG_VERSION="683178362a5261ab83c8eb2f1b383ff4f818fb86"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  DESTDIR=${INSTALL}/$(get_full_firmware_dir)/aic8800/SDIO/
  mkdir -p ${DESTDIR} ||:
  echo $(realpath ${DESTDIR}/aic8800D80)
  cp -PR aic8800/SDIO/aic8800D80 ${DESTDIR}
  ls -l $(realpath ${DESTDIR}/aic8800D80)
}
