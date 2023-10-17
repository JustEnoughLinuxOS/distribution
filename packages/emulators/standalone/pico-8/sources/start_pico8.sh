#!/bin/bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Fewtarius

# Source predefined functions and variables
. /etc/profile

GAME_DIR="/storage/roms/pico-8/"

case ${HW_ARCH} in
  aarch64)
    STATIC_BIN="pico8_64"
  ;;
  *)
    STATIC_BIN="pico8"
  ;;
esac

if [ ! -z "${1}" ] && [ -s "${1}" ]
then
  OPTIONS="-run"
  CART="${1}"
else
  OPTIONS="-splore"
fi

INTEGER_SCALE=$(get_setting pico-8.integerscale)
if [ "${INTEGER_SCALE}" = "1" ]
then
  OPTIONS="${OPTIONS} -pixel_perfect 1"
fi

if [ -d "${GAME_DIR}/${HW_ARCH}" ]
then
  LAUNCH_DIR="${GAME_DIR}/${HW_ARCH}"
else
  LAUNCH_DIR="${GAME_DIR}"
fi

cp -f /usr/config/SDL-GameControllerDB/gamecontrollerdb.txt ${LAUNCH_DIR}/sdl_controllers.txt

if [ -e "${LAUNCH_DIR}/pico8_dyn" ] || [ ! "$?" = 0 ]
then
  jslisten set "-9 pico8_dyn"
  ${LAUNCH_DIR}/pico8_dyn -home -root_path ${GAME_DIR} -joystick 0 ${OPTIONS} "${CART}"
fi

if [ -e "${LAUNCH_DIR}/${STATIC_BIN}" ] || [ ! "$?" = 0 ]
then
  jslisten set "-9 ${STATIC_BIN}"
  ${LAUNCH_DIR}/${STATIC_BIN} -home -root_path ${GAME_DIR} -joystick 0 ${OPTIONS} "${CART}"
  exit
else
  text_viewer -e -w -t "Missing Pico-8 binaries!" -m "Extract your purchased pico8 package into the pico-8 directory on your games partition."
fi

ret_error=$?

exit $ret_error
