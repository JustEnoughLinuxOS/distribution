#!/bin/sh
# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2021-present - Fewtarius

. /etc/profile

ARG=${1//[\\]/}
set_audio pulseaudio
if [ ! -d "/storage/.config/PCSX2" ]
then
  cp -rf /usr/config/PCSX2 /storage/.config
fi
@APPIMAGE@ -fastboot -- "${AR}G"
set_audio alsa
