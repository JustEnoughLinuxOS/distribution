#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

source /etc/profile

set_kill set "retroarch"

/usr/bin/retroarch --appendconfig /usr/config/retroarch/retroarch64bit-append.cfg
