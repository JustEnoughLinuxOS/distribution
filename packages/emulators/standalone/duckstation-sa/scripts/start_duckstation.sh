#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

. /etc/profile

#Copy config folder to .config/duckstation
if [ ! -d "/storage/.config/duckstation" ]; then
    mkdir -p "/storage/.config/duckstation"
        cp -r "/usr/config/duckstation" "/storage/.config/"
fi

#Link savestates to roms/savestates
if [ ! -d "/storage/roms/savestates/psx" ]; then
    mkdir -p "/storage/roms/savestates/psx"
fi
if [ -d "/storage/.config/duckstation/savestates" ]; then
    rm -rf "/storage/.config/duckstation/savestates"
fi
ln -sfv "/storage/roms/savestates/psx" "/storage/.config/duckstation/savestates"

#Copy gamecontroller db file from the device. 
cp -rf /storage/.config/SDL-GameControllerDB/gamecontrollerdb.txt /storage/.config/duckstation/database/gamecontrollerdb.txt
cp -rf /storage/.config/SDL-GameControllerDB/gamecontrollerdb.txt /storage/.config/duckstation/resources/gamecontrollerdb.txt

#Set the cores to use
CORES=$(get_setting "cores" "${PLATFORM}" "${ROMNAME##*/}")
if [ "${CORES}" = "little" ]
then
  EMUPERF="${SLOW_CORES}"
elif [ "${CORES}" = "big" ]
then
  EMUPERF="${FAST_CORES}"
else
  ### All..
  unset EMUPERF
fi

#Run Duckstation
${EMUPERF} duckstation-nogui -fullscreen -settings "/storage/.config/duckstation/settings.ini" -- "${1}" > /dev/null 2>&1
