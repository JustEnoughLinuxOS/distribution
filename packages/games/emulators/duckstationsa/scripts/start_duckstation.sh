#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

. /etc/profile

if [ ! -d "/storage/.config/duckstation" ]; then
    mkdir -p "/storage/.config/duckstation"
        cp -r "/usr/config/duckstation" "/storage/.config/"
fi

if [ ! -d "/storage/roms/savestates/psx" ]; then
    mkdir -p "/storage/roms/savestates/psx"
fi

if [ -d "/storage/.config/duckstation/savestates" ]; then
    rm -rf "/storage/.config/duckstation/savestates"
fi

ln -sfv "/storage/roms/savestates/psx" "/storage/.config/duckstation/savestates"

cp -rf /storage/.config/SDL-GameControllerDB/gamecontrollerdb.txt /storage/.config/duckstation/database/gamecontrollerdb.txt
cp -rf /storage/.config/SDL-GameControllerDB/gamecontrollerdb.txt /storage/.config/duckstation/resources/gamecontrollerdb.txt

duckstation-nogui -fullscreen -settings "/storage/.config/duckstation/settings.ini" -- "${1}" > /dev/null 2>&1
