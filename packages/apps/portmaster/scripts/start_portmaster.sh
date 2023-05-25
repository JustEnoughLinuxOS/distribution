#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023-present BrooksyTech (https://github.com/brooksytech)

. /etc/profile

#Make sure PortMaster exists in .config/PortMaster
if [ ! -d "/storage/.config/PortMaster" ]; then
    mkdir -p "/storage/.config/ports/PortMaster"
      cp -r "/usr/config/PortMaster" "/storage/.config/"
fi

cd /storage/.config/PortMaster

#Grab the latest PortMaster.sh script
cp /usr/config/PortMaster/PortMaster.sh PortMaster.sh

#Use our gamecontrollerdb.txt
rm gamecontrollerdb.txt
ln -sf /usr/config/SDL-GameControllerDB/gamecontrollerdb.txt gamecontrollerdb.txt

#Use our gptokeyb
rm gptokeyb
ln -sf /usr/bin/gptokeyb gptokeyb
cp /usr/config/PortMaster/portmaster.gptk portmaster.gptk

#Use our wget
ln -sf /usr/bin/wget wget

#Make sure roms/ports/PortMaster folder exists
if [ ! -d "/storage/roms/ports/PortMaster" ]; then
    mkdir -p "/storage/roms/ports/PortMaster"
fi

#Make sure libs the folder exists
if [ ! -d "/storage/roms/ports/PortMaster/libs" ]; then
    mkdir -p "/storage/roms/ports/PortMaster/libs"
fi

#Copy over required files for ports
cp /storage/.config/PortMaster/control.txt /storage/roms/ports/PortMaster/control.txt
cp /storage/.config/PortMaster/gptokeyb /storage/roms/ports/PortMaster/gptokeyb
cp -sf /storage/.config/PortMaster/gamecontrollerdb.txt /storage/roms/ports/PortMaster/gamecontrollerdb.txt

#Delete and refrence to PortMaster.sh, we only want to use ours.
find /storage/roms/ports -type f -name "PortMaster.sh" -delete

#Start PortMaster
run ./PortMaster.sh 2>/dev/null

#Kill gptokeyb at exit
pkill -9 gptokeyb
