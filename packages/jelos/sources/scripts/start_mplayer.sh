#!/bin/bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present redwolftech
# Copyright (C) 2020-present Fewtarius

. /etc/profile
jslisten set "mpv"

FBHEIGHT=$(fbset | awk '/geometry/ {print $2}')
FBWIDTH=$(fbset | awk '/geometry/ {print $3}')

ASPECT=$(printf "%.2f" $(echo "(${FBWIDTH} / ${FBHEIGHT})" | bc -l))

case ${ASPECT} in
  1.*)
   RES="${FBWIDTH}x${FBHEIGHT}"
  ;;
  0.*)
   RES="${FBHEIGHT}x${FBWIDTH}"
  ;;
esac

/usr/bin/mpv --fullscreen --geometry=${RES} --hwdec=auto --input-ipc-server=/tmp/mpvsocket "${1}"
exit 0
