#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present Fewtarius

source /etc/profile

jslisten set "killall installer"

weston-terminal -f --command "/usr/bin/installer"
