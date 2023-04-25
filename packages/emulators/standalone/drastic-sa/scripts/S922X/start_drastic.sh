#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023-present BrooksyTech (https://github.com/brooksytech)

. /etc/profile

#Copy drastic files to .config
if [ ! -d "/storage/.config/drastic" ]; then
  mkdir -p /storage/.config/drastic/
  cp -r /usr/config/drastic/* /storage/.config/drastic/
fi

#Make drastic savestate folder
if [ ! -d "/storage/roms/savestates/nds" ]; then
  mkdir -p /storage/roms/savestates/nds
fi

#Link savestates to roms/savestates/nds
rm -rf /storage/.config/drastic/savestates
ln -sf /storage/roms/savestates/nds /storage/.config/drastic/savestates

#Link saves to roms/nds/saves
rm -rf /storage/.config/drastic/backup
ln -sf /storage/roms/nds /storage/.config/drastic/backup

# Set the cores to use
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

cd /storage/.config/drastic/

export SDL_VIDEO_GL_DRIVER=./libs/libGL.so.1
export SDL_VIDEO_EGL_DRIVER=./libs/libEGL.so.1
export LIBGL_ES=2
export LIBGL_GL=21
export LIBGL_FB=2

${EMUPERF} ./drastic "$1"
