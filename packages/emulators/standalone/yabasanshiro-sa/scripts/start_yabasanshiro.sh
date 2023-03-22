#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present Shanti Gilbert (https://github.com/shantigilbert)
# Copyright (C) 2022-present Fewtarius

# Source predefined functions and variables
. /etc/profile

ROM_DIR="/storage/roms/saturn/yabasanshiro"
CONFIG_DIR="/storage/.config/yabasanshiro"
SOURCE_DIR="/usr/config/yabasanshiro"
BIOS_BACKUP="/storage/roms/bios/yabasanshiro"

if [ ! -d "${ROM_DIR}" ]
then
  mkdir -p "${ROM_DIR}"
fi

if [ ! -d "${BIOS_BACKUP}" ]
then
  mkdir -p "${BIOS_BACKUP}"
fi

if [ ! -e "${CONFIG_DIR}/input.cfg" ]
then
  GAMEPAD=$(grep -b4 js0 /proc/bus/input/devices | awk 'BEGIN {FS="\""}; /Name/ {printf $2}')
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

BIOS=""
GAME=$(echo "${1}"| sed "s#^/.*/##")
USE_BIOS=$(get_setting use_hlebios saturn "${GAME}")
if [ ! "${USE_BIOS}" = 1 ]
then
  USE_BIOS=$(get_setting use_hlebios saturn)
fi

if [ "$USE_BIOS" = 1 ]
then
  for BIOS in saturn_bios.bin sega_101.bin mpr-17933.bin mpr-18811-mx.ic1 mpr-19367-mx.ic1 stvbios.zip
  do
    BIOS=$(find /storage/roms/bios -name ${BIOS} -print 2>/dev/null)
    if [ ! -z "${BIOS}" ]
    then
      BIOS="-b ${BIOS}"
      break
    fi
  done
fi

if [ ! -e "${CONFIG_DIR}/${GAME}.config" ]
then
  cp -f ${SOURCE_DIR}/.config "${CONFIG_DIR}/${GAME}.config"
fi

echo "Command: yabasanshiro -r 2 -i "${1}" ${BIOS}" >/var/log/exec.log 2>&1
yabasanshiro -r 2 -i "${1}" ${BIOS} >>/var/log/exec.log 2>&1 ||:
