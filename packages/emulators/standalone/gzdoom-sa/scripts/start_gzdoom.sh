#!/usr/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present 351ELEC (https://github.com/351ELEC)

. /etc/profile
jslisten set "-9 gzdoom"

RUN_DIR="/storage/roms/doom"
CONFIG="/storage/.config/gzdoom/gzdoom.ini"
SAVE_DIR="/storage/roms/gzdoom"

if [ ! -d "/storage/.config/gzdoom/" ]; then
  cp -rf /usr/config/gzdoom /storage/.config/
fi

if [ ! -f "/storage/.config/gzdoom/gzdoom.ini" ]; then
  cp -rf /usr/config/gzdoom/gzdoom.ini /storage/.config/gzdoom/
fi

if [ ! -d "/storage/roms/doom/iwads" ]; then
  mkdir /storage/roms/doom/iwads
fi

if [ ! -d "/storage/roms/doom/mods" ]; then
  mkdir /storage/roms/doom/mods
fi

mkdir -p ${SAVE_DIR}

params=" -config ${CONFIG} -savedir ${SAVE_DIR}"
params+=" +gl_es 1 +vid_preferbackend 3 +cl_capfps 0 +vid_fps 0"

# EXT can be wad, WAD, iwad, IWAD, pwad, PWAD or doom
EXT=${1##*.}

# If its not a simple wad (extension .doom) read the file and parse the data
if [ ${EXT} == "doom" ]; then
  dos2unix "${1}"
  while IFS== read -r key value; do
    if [ "$key" == "IWAD" ]; then
      params+=" -iwad $value"
    fi
    if [ "$key" == "MOD" ]; then
      params+=" -file $value"
    fi
  done <"${1}"
else
  params+=" -iwad ${1}"
fi

cd "${RUN_DIR}"
echo ${params} | xargs /usr/bin/gzdoom >/var/log/gzdoom.log 2>&1
