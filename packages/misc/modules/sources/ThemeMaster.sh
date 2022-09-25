#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Fewtarius
# Maintenance 2022-present BrooksyTech (https://github.com/brooksytech)

. /etc/profile

if [ "${UI_SERVICE}" = "weston.service" ]
then
  sed -i -e "s#/dev/tty1#/dev/tty#" /storage/roms/ports/ThemeMaster/ThemeMaster
fi

/storage/roms/ports/ThemeMaster.sh
