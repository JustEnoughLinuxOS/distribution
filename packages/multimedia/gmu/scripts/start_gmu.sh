#!/bin/bash
# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2023-present Fewtarius

. /etc/profile

jslisten set "gmu.bin"

GMUPATH="/storage/.config/gmu"
GMUCONFIG="${GMUPATH}/gmu.conf"

if [ -d "/storage/.local/share/gmu" ]
then
  rm -rf /storage/.local/share/gmu
fi

ln -sf ${GMUPATH}/playlists /storage/.local/share/gmu

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

if [ "${1}" ]
then
  PLAYLIST="-l \"${1}\""
fi

cd /usr/local/share/gmu
/usr/local/bin/gmu.bin -d /usr/local/etc/gmu -c /storage/.config/gmu/gmu.conf ${PLAYLIST}
