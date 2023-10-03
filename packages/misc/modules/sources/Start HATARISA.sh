#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Fewtarius

source /etc/profile

jslisten set "hatarisa"

/usr/bin/hatarisa >/dev/null 2>&1
