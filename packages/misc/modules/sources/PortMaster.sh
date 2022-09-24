#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Fewtarius
# Maintenance 2022-present BrooksyTech (https://github.com/brooksytech)

if [ "${UI_SERVICE}" = "weston.service" ]
then
  sed -i -e "s#[2]\>.*tty0##" -e "s#\>.*dev/tty0##g" /storage/roms/ports/PortMaster.sh
fi
/storage/roms/ports/PortMaster.sh
