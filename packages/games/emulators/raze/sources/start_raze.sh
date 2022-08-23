#!/usr/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present 351ELEC (https://github.com/351ELEC)

. /etc/profile
. /etc/os-release

EE_DEVICE=${HW_DEVICE}
RUN_DIR="/storage/roms/build"
CONFIG="/storage/.config/game/raze/raze.ini"
SAVE_DIR="/storage/roms/gamedata/raze"

if [ ! -L "/storage/.config/raze" ]; then
  ln -sf "/storage/.config/game/raze" "/storage/.config/raze"
fi

if [ ! -f "/storage/.config/game/raze/raze.ini" ]; then
  cp -rf /usr/config/game/raze/raze.ini /storage/.config/game/raze/
fi

mkdir -p ${SAVE_DIR}

params=" -config ${CONFIG} -savedir ${SAVE_DIR}"
params+=" +gl_es 1 +vid_preferbackend 3 +cl_capfps 0 +cl_nomeleeblur 1 +vid_fps 1"

EXT=${1##*.}

if [ ${EXT} == "build" ]; then
  dos2unix "${1}"
  while IFS== read -r key value; do
    if [ "$key" == "PATH" ]; then
      # Unquote path value
      temp="${value}"
      temp="${temp%\"}"
      temp="${temp#\"}"
      RUN_DIR+="/$temp"
    fi
    if [ "$key" == "GRP" ]; then
      params+=" -gamegrp $value"
    fi
  done <"${1}"
fi

cd "${RUN_DIR}"
/usr/bin/raze ${params} >/var/log/raze.log 2>&1
