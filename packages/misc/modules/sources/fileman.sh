#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)
# Copyright (C) 2020-present Fewtarius

. /etc/profile
jslisten set "killall FileMan"

if [ -e "/sys/firmware/devicetree/base/model" ]
then
  QUIRK_DEVICE=$(cat /sys/firmware/devicetree/base/model 2>/dev/null)
else
  QUIRK_DEVICE="$(cat /sys/class/dmi/id/sys_vendor 2>/dev/null) $(cat /sys/class/dmi/id/product_name 2>/dev/null)"
fi
QUIRK_DEVICE="$(echo ${QUIRK_DEVICE} | sed -e "s#[/]#-#g")"

if [ ${QUIRK_DEVICE} == "Anbernic RG503" ]
then
  fileman.rg503
else
  fileman
