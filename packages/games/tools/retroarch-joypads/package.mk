# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2020-present Fewtarius

PKG_NAME="retroarch-joypads"
PKG_VERSION="2b684470296b665470f6f6ec70075fa6ad254a11"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/retroarch-joypad-autoconfig"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="RetroArch joypad autoconfigs."
PKG_TOOLCHAIN="manual"

make_target() {
  :
}

makeinstall_target() {
  INSTALLDIR="${INSTALL}/usr/share/libretro/autoconfig"
  mkdir -p ${INSTALLDIR}
  for JOYDIR in linuxraw sdl2 udev x xinput
  do
    cp ${PKG_BUILD}/${JOYDIR}/*cfg ${INSTALLDIR}
  done
  if [ -d "${PKG_DIR}/gamepads/device/${DEVICE}" ]
  then
    cp -r ${PKG_DIR}/gamepads/device/${DEVICE}/* ${INSTALLDIR} ||:
  fi
}

post_install() {
  enable_service tmp-joypads.mount
}
