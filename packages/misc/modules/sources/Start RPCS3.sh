#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Fewtarius

source /etc/profile

jslisten set "rpcs3"

/usr/bin/rpcs3 >/dev/null 2>&1
