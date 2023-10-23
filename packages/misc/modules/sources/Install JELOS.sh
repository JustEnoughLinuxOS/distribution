#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023-present - The JELOS Project (https://github.com/JustEnoughLinuxOS)

source /etc/profile

jslisten set "installer"

weston-terminal -f --command "/usr/bin/installer"
