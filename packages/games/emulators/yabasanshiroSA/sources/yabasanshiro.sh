#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present Shanti Gilbert (https://github.com/shantigilbert)
# Copyright (C) 2022-present Fewtarius

# Source predefined functions and variables
. /etc/profile

ROM_DIR="/storage/roms/saturn/yabasanshiro"
CONFIG_DIR="/storage/.config/game/configs/yabasanshiro"
SOURCE_DIR="/usr/config/game/configs/yabasanshiro"

if [ ! -d "${ROM_DIR}" ]
then
  mkdir -p "${ROM_DIR}"
fi

ROMNAME=$(basename "${1}")
BIOS=""

if [ ! -e "${ROM_DIR}/${ROM_DIR}/input.cfg" ]
then
  GAMEPAD=$(grep -b4 $(readlink ${DEVICE_CONTROLLER_DEV} | sed "s#^.*/##") /proc/bus/input/devices | awk 'BEGIN {FS="\""}; /Name/ {printf $2}')
  GAMEPADCONFIG=$(xmlstarlet sel -t -c '//inputList/inputConfig[@deviceName="'${GAMEPAD}'"]' -n /storage/.emulationstation/es_input.cfg)

  if [ ! -z "${GAMEPADCONFIG}" ]
  then
    cat <<EOF >${ROM_DIR}/input.cfg
<?xml version="1.0"?>
<inputList>
${GAMEPADCONFIG}
</inputList>
EOF
  fi
fi

yabasanshiro -r 2 -i "${1}" -b /storage/roms/bios/saturn_bios.bin >/var/log/exec.log 2>&1 ||:
