#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present JELOS (https://github.com/JustEnoughLinuxOS)

. /etc/profile
jslisten set "-9 Vita3K"

#Check if vita3k folder exists in /storage/.config/vita3k
if [ ! -d "/storage/.config/vita3k" ]; then
    mkdir -p "/storage/.config/vita3k"
        cp -r "/usr/config/vita3k" "/storage/.config/"
fi

#Check if vita3k folder exists in /storage/roms/psvita
if [ ! -d "/storage/roms/psvita/vita3k" ]; then
    mkdir -p "/storage/roms/psvita/vita3k"
fi

#Start Vita3K
/usr/bin/Vita3K
