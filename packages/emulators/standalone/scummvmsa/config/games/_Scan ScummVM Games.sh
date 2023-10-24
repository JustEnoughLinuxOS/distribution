#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)
# Copyright (C) 2023-present - The JELOS Project (https://github.com/JustEnoughLinuxOS)

. /etc/profile

clear
echo "Scanning for games..."
bash /usr/bin/start_scummvm.sh add
echo "Adding games..."
bash /usr/bin/start_scummvm.sh create
clear
