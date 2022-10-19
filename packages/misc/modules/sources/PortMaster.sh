#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Fewtarius
# Maintenance 2022-present BrooksyTech (https://github.com/brooksytech)

. /etc/profile

if [ "${UI_SERVICE}" = "weston.service" ]
then
  sed -i -e "s#/dev/tty0#/dev/tty#" /storage/roms/ports/PortMaster.sh
fi

cd /storage/roms/ports/PortMaster
./PortMaster.sh

if [ -e "/storage/roms/ports/PortMaster.sh" ]
then
  mv /storage/roms/ports/PortMaster.sh /storage/roms/ports/PortMaster/
fi
