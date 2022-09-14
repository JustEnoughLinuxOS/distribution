#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)
. /etc/profile

if [ ! -d "/storage/.config/drastic" ]; then

echo "Drastic emulator not installed." 2>&1
echo "Please install through the Jelos Add Ons tool." 2>&1

sleep 5
clear

else


cd /storage/.config/drastic/aarch64/drastic/

./drastic "$1"

fi
