#!/bin/sh
# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2021-present - Fewtarius

. /etc/profile

ARG=${1//[\\]/}

jslisten set "-9 pcsx2-qt"

if [ ! -d "/storage/.config/PCSX2" ]
then
  cp -rf /usr/config/PCSX2 /storage/.config
fi

#Create PS2 bios folder
if [ ! -d "/storage/roms/bios/pcsx2/bios" ]
then
  mkdir -p "/storage/roms/bios/pcsx2/bios"
fi

#Create PS2 saves & savestates folders
if [ ! -d "/storage/roms/saves/ps2" ]
then
  mkdir -p "/storage/roms/saves/ps2"
fi
if [ ! -d "/storage/roms/savestates/ps2" ]
then
  mkdir -p "/storage/roms/savestates/ps2"
fi

@APPIMAGE@ -fastboot -nogui -- "${ARG}"

#Workaround until we can learn why it doesn't exit cleanly when asked.
killall -9 pcsx2-qt