#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present - The JELOS Project (https://github.com/JustEnoughLinuxOS)

. /etc/profile
jslisten set "PortMaster"

#Make sure PortMaster exists in .config/PortMaster
if [ ! -d "/storage/.config/PortMaster" ]; then
    mkdir -p "/storage/.config/ports/PortMaster"
      cp -r "/usr/config/PortMaster" "/storage/.config/"
fi

cd /storage/.config/PortMaster

#Grab the latest control.txt
cp /usr/config/PortMaster/control.txt control.txt

#Use our gamecontrollerdb.txt
rm -r gamecontrollerdb.txt
ln -sf /usr/config/SDL-GameControllerDB/gamecontrollerdb.txt gamecontrollerdb.txt

#Delete old PortMaster fold first (we can probably remove this later)
if [ ! -f "/storage/roms/ports/PortMaster/pugwash" ]; then
    rm -r /storage/roms/ports/PortMaster
fi

#Make sure roms/ports/PortMaster folder exists
if [ ! -d "/storage/roms/ports/PortMaster" ]; then
    unzip /usr/config/PortMaster/release/PortMaster.zip -d /storage/roms/ports/
    chmod +x /storage/roms/ports/PortMaster/PortMaster.sh
fi

#Use PortMasters gptokeyb
rm gptokeyb
cp /storage/roms/ports/PortMaster/gptokeyb gptokeyb

#Copy over required files for ports
cp /storage/.config/PortMaster/control.txt /storage/roms/ports/PortMaster/control.txt
cp /storage/.config/PortMaster/gamecontrollerdb.txt /storage/roms/ports/PortMaster/gamecontrollerdb.txt
cp /usr/bin/oga_controls* /storage/roms/ports/PortMaster/

#Start PortMaster
@LIBEGL@

cd /storage/roms/ports/PortMaster
run ./PortMaster.sh 2>/dev/null
