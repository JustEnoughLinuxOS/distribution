#!/usr/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present 351ELEC (https://github.com/351ELEC/351ELEC)

. /etc/profile
. /etc/os-release

EE_DEVICE=${HW_DEVICE}
RUN_DIR="/storage/roms/doom"
CONFIG="/storage/.config/game/lzdoom/lzdoom.ini"
SAVE_DIR="/storage/roms/gamedata/lzdoom"

if [ ! -L "/storage/.config/lzdoom" ]; then
  ln -sf "/storage/.config/game/lzdoom" "/storage/.config/lzdoom"
fi

if [ ! -f "/storage/.config/game/lzdoom/lzdoom.ini" ]; then
  cp -rf /usr/config/game/lzdoom/lzdoom.ini /storage/.config/game/lzdoom/
fi

mkdir -p ${SAVE_DIR}

params=" -config ${CONFIG} -savedir ${SAVE_DIR}"
params+=" -width 1152 -height 1920 +vid_fps 1 +cl_capfps 0 +vid_renderer 0 +vid_glswfb 0"

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
echo ${params} | xargs /usr/bin/lzdoom >/var/log/lzdoom.log 2>&1
