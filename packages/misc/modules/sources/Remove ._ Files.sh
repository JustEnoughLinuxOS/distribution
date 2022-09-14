#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)
# Copyright (C) 2020-present Fewtarius

. /etc/profile
source /usr/bin/env.sh
clear >/dev/console
stop_ui
echo "Cleaning ._ files from /storage/roms" >/dev/console
find /storage/roms -iname '._*' -exec rm -rf {} \;
clear >/dev/console
start_ui
