#!/bin/bash
# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2023-present Fewtarius

. /etc/profile

jslisten set "-9 gmu.bin"

GMUCONFIG="/storage/.config/gmu/gmu.conf"

FBHEIGHT=$(fbset | awk '/geometry/ {print $2}')
FBWIDTH=$(fbset | awk '/geometry/ {print $3}')
sed -i "s~SDL.Height=.*\$~SDL.Height=${FBHEIGHT}~g" ${GMUCONFIG}
sed -i "s~SDL.Width=.*\$~SDL.Height=${FBWIDTH}~g" ${GMUCONFIG}

cd /usr/local/share/gmu
/usr/local/bin/gmu.bin -d /usr/local/etc/gmu -c /storage/.config/gmu/gmu.conf
