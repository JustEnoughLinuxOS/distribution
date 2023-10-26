#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present Shanti Gilbert (https://github.com/shantigilbert)
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

# Source predefined functions and variables
. /etc/profile
jslisten set "-9 kronos"

ROM_DIR="/storage/roms/saturn/kronos"
CONFIG_DIR="/storage/.config/kronos/qt"
SOURCE_DIR="/usr/config/kronos"
BIOS_BACKUP="/storage/roms/bios/kronos"

if [ ! -d "${ROM_DIR}" ]
then
  mkdir -p "${ROM_DIR}"
fi

if [ ! -d "${BIOS_BACKUP}" ]
then
  mkdir -p "${BIOS_BACKUP}"
fi

if [ ! -d "${CONFIG_DIR}" ]
then
  mkdir -p "${CONFIG_DIR}"
fi

if [ ! -e "${CONFIG_DIR}/kronos.ini" ]
then
  cp -f ${SOURCE_DIR}/kronos.ini ${CONFIG_DIR}
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

echo "Command: kronos -r 2 -i "${1}" ${BIOS}" >/var/log/exec.log 2>&1
${EMUPERF} kronos -a -f  -i "${1}" -b ${BIOS} >>/var/log/exec.log 2>&1 ||:
