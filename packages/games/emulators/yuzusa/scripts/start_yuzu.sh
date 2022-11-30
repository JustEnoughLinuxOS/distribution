#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

. /etc/profile

#Check if yuzu exists in .config
if [ ! -d "/storage/.config/yuzu" ]; then
    mkdir -p "/storage/.config/yuzu"
        cp -r "/usr/config/yuzu" "/storage/.config/"
fi

#Link yuzu keys to bios folder
if [ ! -d "/storage/roms/bios/yuzu" ]; then
    mkdir -p "/storage/.config/yuzu"
fi
rm -rf /storage/.config/yuzu/keys
ln -sf /storage/roms/bios/yuzu /storage/.config/yuzu/keys

#Link  .config/yuzu to .local
rm -rf /storage/.local/share/yuzu
ln -sf /storage/.config/yuzu /storage/.local/share/yuzu

#Run Yuzu emulator
/usr/bin/yuzu-cmd "${1}"
