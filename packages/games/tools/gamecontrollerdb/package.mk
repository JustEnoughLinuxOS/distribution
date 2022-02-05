# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2021-present Fewtarius (https://github.com/fewtarius)

PKG_NAME="gamecontrollerdb"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_DEPENDS_TARGET="toolchain SDL2"
PKG_SECTION="tools"
PKG_SHORTDESC="SDL Game Controller DB"
PKG_TOOLCHAIN="manual"

make_target() {
  echo
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/config/SDL-GameControllerDB

  if [ "$DEVICE" == "RG351P" ] || [ "$DEVICE" == "RG351V" ]; then
  cat <<EOF >${INSTALL}/usr/config/SDL-GameControllerDB/gamecontrollerdb.txt
03000000091200000031000011010000,OpenSimHardware OSH PB Controller,a:b0,b:b1,y:b3,x:b2,start:b6,back:b7,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftshoulder:b4,lefttrigger:b10,rightshoulder:b5,righttrigger:b11,leftstick:b8,guide:b9,leftx:a0~,lefty:a1~,rightx:a2,righty:a3,platform:Linux,
EOF
  elif [ "$DEVICE" == "RG351MP" ]; then
  cat <<EOF >${INSTALL}/usr/config/SDL-GameControllerDB/gamecontrollerdb.txt
190000004b4800000011000000010000,GO-Super Gamepad,x:b2,a:b1,b:b0,y:b3,back:b12,start:b13,dpleft:b10,dpdown:b9,dpright:b11,dpup:b8,leftshoulder:b4,lefttrigger:b6,rightshoulder:b5,righttrigger:b7,leftstick:b14,guide:b15,leftx:a0,lefty:a1,rightx:a2,righty:a3,platform:Linux,
EOF
  elif [ "$DEVICE" == "RG552" ]; then
  cat <<EOF >${INSTALL}/usr/config/SDL-GameControllerDB/gamecontrollerdb.txt
190000004b4800000111000000010000,retrogame_joypad,platform:Linux,a:b1,b:b0,x:b2,y:b3,back:b8,start:b9,rightstick:b12,leftstick:b11,dpleft:b15,dpdown:b14,dpright:b16,dpup:b13,leftshoulder:b4,lefttrigger:b6,rightshoulder:b5,righttrigger:b7,leftx:a0,lefty:a1,rightx:a2,righty:a3,
EOF
  fi

  cat ${PKG_DIR}/sources/gamecontrollerdb.txt >>${INSTALL}/usr/config/SDL-GameControllerDB/gamecontrollerdb.txt
}
