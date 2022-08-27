#!/usr/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present 351ELEC (https://github.com/351ELEC)

. /etc/profile
. /etc/os-release

EE_DEVICE=${HW_DEVICE}
RUN_DIR="/storage/roms/doom"
CONFIG="/storage/.config/game/gzdoom/gzdoom.ini"
SAVE_DIR="/storage/roms/gamedata/gzdoom"

if [ ! -L "/storage/.config/gzdoom" ]; then
  ln -sf "/storage/.config/game/gzdoom" "/storage/.config/gzdoom"
fi

if [ ! -f "/storage/.config/game/gzdoom/gzdoom.ini" ]; then
  cp -rf /usr/config/game/gzdoom/gzdoom.ini /storage/.config/game/gzdoom/
fi

mkdir -p ${SAVE_DIR}

params=" -config ${CONFIG} -savedir ${SAVE_DIR}"
params+=" +gl_es 1 +vid_preferbackend 3 +cl_capfps 0 +vid_fps 1"

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
