#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

. /etc/profile

if [ ! -d "/storage/.config/dolphin-emu" ]; then
    mkdir -p "/storage/.config/dolphin-emu"
        cp -r "/usr/config/dolphin-emu" "/storage/.config/"
fi

if [ ! -d "/storage/.config/dolphin-emu/StateSaves" ]; then
    mkdir -p "/storage/.config/dolphin-emu/StateSaves"
fi

rm -rf /storage/.local/share/dolphin-emu

ln -sfv /storage/.config/dolphin-emu /storage/.local/share/dolphin-emu

/usr/bin/dolphin-emu-nogui -p @DOLPHIN_PLATFORM@ -a HLE -e "${1}"
