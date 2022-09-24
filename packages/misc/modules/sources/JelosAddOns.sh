#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright 2022-present BrooksyTech (https://github.com/brooksytech)

. /etc/profile

if [ "${UI_SERVICE}" = "weston.service" ]
then
  sed -i -e "s#/dev/tty0#/dev/tty#" /storage/roms/ports/JelosAddOns.sh
fi
/storage/roms/ports/JelosAddOns.sh
