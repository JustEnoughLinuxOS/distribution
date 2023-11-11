#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

source /etc/profile

jslisten set "Ryujinx"

/storage/.config/Ryujinx/Ryujinx >/dev/null 2>&1
