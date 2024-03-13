#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

source /etc/profile

set_kill set "aethersx2-sa"

/usr/bin/aethersx2-sa >/dev/null 2>&1
