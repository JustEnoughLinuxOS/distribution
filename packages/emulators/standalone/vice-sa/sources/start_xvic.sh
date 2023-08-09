#!/bin/sh
# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2021-present - Fewtarius

. /etc/profile

if [ ! -d "/storage/.config/vice" ]
then
  rsync -a /usr/config/vice /storage/.config
fi

ARG=${1//[\\]/}
echo "[${ARG}]"
xvic -sounddev alsa -sdl2renderer opengles2 "${ARG}"
