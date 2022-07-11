#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present Shanti Gilbert (https://github.com/shantigilbert)
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

. /etc/profile

LOCAL_CONFIG="/storage/.local/share"
CONFIG_DIR="/storage/.config/duckstation"

mkdir -p "/storage/.local/share/duckstation"

if [ ! -d "${CONFIG_DIR}" ]; then
    mkdir -p "${CONFIG_DIR}"
        cp -r "/usr/config/duckstation" "/storage/.config/"
fi

if [ -d "/storage/.local/share/duckstation" ]; then
        rm -rf "/storage/.local/share/duckstation"
fi

if [ ! -L "/storage/.local/share/duckstation" ]; then
    ln -sf "/storage/.config/duckstation" "/storage/.local/share/duckstation"
fi

if [[ "${1}" == *"duckstation_gui.pbp"* ]]; then
    duckstation-nogui -fullscreen
else
    duckstation-nogui -fullscreen -settings "/storage/.config/duckstation/settings.ini" -- "${1}" > /dev/null 2>&1
fi
