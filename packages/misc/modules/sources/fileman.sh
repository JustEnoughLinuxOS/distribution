#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

gptokeyb fileman textinput &

. /etc/profile
jslisten set "FileMan"

if [ -e "/sys/firmware/devicetree/base/model" ]
then
  QUIRK_DEVICE=$(cat /sys/firmware/devicetree/base/model 2>/dev/null)
else
  QUIRK_DEVICE="$(cat /sys/class/dmi/id/sys_vendor 2>/dev/null) $(cat /sys/class/dmi/id/product_name 2>/dev/null)"
fi
QUIRK_DEVICE="$(echo ${QUIRK_DEVICE} | sed -e "s#[/]#-#g")"

if [ "${QUIRK_DEVICE}" == "Anbernic RG503" ]
then
  fileman.rg503
else
  fileman
fi

killall gptokeyb &
