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
@APPIMAGE@ -fastboot -- "${ARG}"
#Workaround until we can learn why it doesn't exit cleanly when asked.
killall -9 pcsx2-qt
