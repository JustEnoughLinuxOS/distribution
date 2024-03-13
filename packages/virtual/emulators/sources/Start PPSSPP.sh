#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

source /etc/profile

set_kill set "ppsspp"

cp -f /storage/.config/SDL-GameControllerDB/gamecontrollerdb.txt /storage/.config/ppsspp/assets/gamecontrollerdb.txt

/usr/bin/ppsspp >/dev/null 2>&1
