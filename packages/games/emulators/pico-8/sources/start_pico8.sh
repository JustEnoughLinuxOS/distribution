#!/bin/bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Fewtarius

# Source predefined functions and variables
. /etc/profile

if [ ! -z "${1}" ] && [ -s "${1}" ]
then
  OPTIONS="-run"
  CART="${1}"
else
  OPTIONS="-splore"
fi

cp -f /usr/config/SDL-GameControllerDB/gamecontrollerdb.txt /storage/roms/pico-8/sdl_controllers.txt

if [ -e "/storage/roms/pico-8/pico8_64" ]
then
  jslisten set "pico8_64"
  /storage/roms/pico-8/pico8_64 -home -root_path /storage/roms/pico-8 -joystick 0 ${OPTIONS} "${CART}"
elif [ -e "/storage/roms/pico-8/pico8_dyn" ] && [ ! -e "/storage/roms/pico-8/pico8_64" ]
then
  jslisten set "pico8_dyn"
  patchelf --set-interpreter /usr/lib32/ld-linux-armhf.so.3 /storage/roms/pico-8/pico8_dyn
  export LD_LIBRARY_PATH=/usr/lib32
  /storage/roms/pico-8/pico8_dyn -home -root_path /storage/roms/pico-8 -joystick 0 ${OPTIONS} "${CART}"
else
  text_viewer -e -w -t "Missing Pico-8 binaries!" -m "Extract your purchased pico8_64 and pico8.dat and place them in the pico-8 directory on your games partition."
fi

ret_error=$?

exit $ret_error
