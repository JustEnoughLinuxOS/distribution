#!/bin/bash
# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2023-present Fewtarius

. /etc/profile

jslisten set "-9 gmu.bin"

GMUPATH="/storage/.config/gmu"
GMUCONFIG="${GMUPATH}/gmu.conf"

FBHEIGHT=$(fbset | awk '/geometry/ {print $2}')
FBWIDTH=$(fbset | awk '/geometry/ {print $3}')

if [ ! -d "${GMUPATH}" ]
then
  cp -rf /usr/config/gmu ${GMUPATH}
fi

sed -i "s~SDL.Height=.*\$~SDL.Height=${FBHEIGHT}~g" ${GMUCONFIG}
sed -i "s~SDL.Width=.*\$~SDL.Width=${FBWIDTH}~g" ${GMUCONFIG}

if (( ${FBWIDTH} <= 800 ))
then
  sed -i "s~default-modern-large~default-modern~g" ${GMUCONFIG}
  sed -i "s~SDL.Fullscreen=.*\$~SDL.Fullscreen=no~g" ${GMUCONFIG}
fi

cd /usr/local/share/gmu
/usr/local/bin/gmu.bin -d /usr/local/etc/gmu -c /storage/.config/gmu/gmu.conf
