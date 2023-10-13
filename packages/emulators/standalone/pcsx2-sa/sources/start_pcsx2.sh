#!/bin/sh
# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2021-present - Fewtarius

. /etc/profile

GAME=${1//[\\]/}

jslisten set "-9 pcsx2-qt"

FPS=$(get_setting show_fps ps2 "${GAME}")

if [ ! -d "/storage/.config/PCSX2" ]
then
  cp -rf /usr/config/PCSX2 /storage/.config
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
