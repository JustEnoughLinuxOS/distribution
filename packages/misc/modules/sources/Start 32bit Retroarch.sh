#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Fewtarius

source /etc/profile

jslisten set "killall retroarch32"

set_kill_keys "retroarch32"
/usr/bin/retroarch32 --appendconfig /usr/config/retroarch/retroarch32bit-append.cfg
