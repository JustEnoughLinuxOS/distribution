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
${FAST_CORES} @APPIMAGE@ "$ARG"
set_audio alsa
