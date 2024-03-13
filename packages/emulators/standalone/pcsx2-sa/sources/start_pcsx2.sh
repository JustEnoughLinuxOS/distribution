#!/bin/sh
# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

. /etc/profile

GAME=${1//[\\]/}

set_kill set "-9 pcsx2-qt"

FPS=$(get_setting show_fps ps2 "${GAME}")

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

for OSDPROPERTY in OsdShowSpeed OsdShowFPS OsdShowCPU OsdShowGPU OsdShowResolution OsdShowGSStats OsdShowIndicators
do
  case ${FPS} in
    true)
      sed -i '/'${OSDPROPERTY}'/c\'${OSDPROPERTY}' = true' /storage/.config/PCSX2/inis/PCSX2.ini
    ;;
    *)
      sed -i '/'${OSDPROPERTY}'/c\'${OSDPROPERTY}' = false' /storage/.config/PCSX2/inis/PCSX2.ini
    ;;
  esac
done

@APPIMAGE@ -fastboot -nogui -- "${GAME}"

#Workaround until we can learn why it doesn't exit cleanly when asked.
killall -9 pcsx2-qt
