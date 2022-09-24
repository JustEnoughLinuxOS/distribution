#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)
# Copyright (C) 2020-present Fewtarius

. /etc/profile
clear
echo "Cleaning ._ files from /storage/roms"
find /storage/roms -iname '._*' -exec rm -rf {} \;
clear
