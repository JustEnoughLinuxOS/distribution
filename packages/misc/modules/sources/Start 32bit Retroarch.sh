#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Fewtarius

source /etc/profile

jslisten set "killall retroarch32"
export LIBGL_DRIVERS_PATH="/usr/lib32/dri"
/usr/bin/retroarch32 --appendconfig /usr/config/retroarch/retroarch32bit-append.cfg
