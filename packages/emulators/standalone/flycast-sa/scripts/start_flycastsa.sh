#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023-present BrooksyTech (https://github.com/brooksytech)

. /etc/profile

#Check if flycast exists in .config
if [ ! -d "/storage/.config/flycast" ]; then
    mkdir -p "/storage/.config/flycast"
        cp -r "/usr/config/flycast" "/storage/.config/"
fi

#Make flycast bios folder
if [ ! -d "/storage/roms/bios/dc" ]; then
    mkdir -p "/storage/roms/bios/dc"
fi

#Link  .config/flycast to .local
rm -rf "/storage/.local/share/flycast"
ln -sf "/storage/.config/flycast" "/storage/.local/share/flycast"
ln -sf "/storage/roms/bios/dc" "/storage/.local/share/flycast"

#Run flycast emulator
/usr/bin/flycast "${1}"
