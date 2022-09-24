#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright 2022-present BrooksyTech (https://github.com/brooksytech)

if [ "${UI_SERVICE}" = "weston.service" ]
then
  sed -i -e "s#/dev/tty0#/dev/tty#" /storage/roms/PortMaster.sh
fi
/storage/roms/ports/JelosAddOns.sh
