#!/bin/bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present 351ELEC (https://github.com/351ELEC)
# Copyright (C) 2022-present Fewtarius

. /etc/profile

CONFIG_DIR="/storage/.advance"

if [ ! -d "${CONFIG_DIR}" ]; then
 mkdir -p ${CONFIG_DIR}
 cp -rf /usr/share/advance/* ${CONFIG_DIR}/
 GAMEPAD=$(grep -b4 $(readlink ${DEVICE_CONTROLLER_DEV} | sed "s#^.*/##") /proc/bus/input/devices | awk 'BEGIN {FS="\""}; /Name/ {printf $2}')
 cat /usr/share/advance/advmame.rc | sed "s#@DEVICE_GAMEPAD@#${GAMEPAD}#g" >${CONFIG_DIR}/advmame.rc
fi

if [[ "$1" = *"roms/arcade"* ]]; then
 sed -i "s|/roms/mame|/roms/arcade|g" ${CONFIG_DIR}/advmame.rc
else
 sed -i "s|/roms/arcade|/roms/mame|g" ${CONFIG_DIR}/advmame.rc
fi

sed -i '/device_video_modeline/d' ${CONFIG_DIR}/advmame.rc

ARG=$(echo basename $1 | sed 's/\.[^.]*$//')
ARG="$(echo $1 | sed 's=.*/==;s/\.[^.]*$//')"

SDL_AUDIODRIVER=alsa nice -n -19 /usr/bin/advmame ${ARG} -quiet
