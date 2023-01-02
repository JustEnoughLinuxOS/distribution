#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

. /etc/profile

if [ ! -d "/storage/.config/citra-emu" ]; then
    mkdir -p "/storage/.config/citra-emu"
        cp -r "/usr/config/citra-emu" "/storage/.config/"
fi

rm -rf /storage/.local/share/citra-emu

ln -sfv /storage/.config/citra-emu /storage/.local/share/citra-emu

/usr/bin/citra "${1}"
