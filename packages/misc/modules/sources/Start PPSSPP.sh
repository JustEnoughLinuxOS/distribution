#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Fewtarius

source /etc/profile

jslisten set "killall ppsspp"

cp -f /storage/.config/SDL-GameControllerDB/gamecontrollerdb.txt /storage/.config/ppsspp/assets/gamecontrollerdb.txt

/usr/bin/ppsspp >/dev/null 2>&1
