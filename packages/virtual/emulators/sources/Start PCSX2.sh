#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Fewtarius

source /etc/profile

jslisten set "pcsx2-sa"

/usr/bin/pcsx2-sa >/dev/null 2>&1
