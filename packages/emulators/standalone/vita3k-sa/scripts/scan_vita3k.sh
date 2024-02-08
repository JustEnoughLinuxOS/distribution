#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present JELOS (https://github.com/JustEnoughLinuxOS)

. /etc/profile

GAME_PATH="/storage/psvita/vita3k/ux0/app"
GAME_DATA="/storage/.config/vita3k/vita-gamelist.txt"
OUTPUT_PATH="/storage/.config/vita3k/launcher"

cd ${GAME_PATH}
for GAME in PC*
do
  FILENAME=$(grep ${GAME} ${GAME_DATA} | sed 's~'${GAME}'\t~~g')
  if [ ! -e "${OUTPUT_PATH}/${FILENAME}.psvita" ] && \
     [ -n "${FILENAME}" ]
  then
    echo ${GAME} > ${OUTPUT_PATH}/"${FILENAME}.psvita"
  fi
done
