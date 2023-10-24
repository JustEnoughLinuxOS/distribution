#!/bin/sh
# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2023-present - The JELOS Project (https://github.com/JustEnoughLinuxOS)

. /etc/profile

ARG=${1//[\\]/}
echo "[${ARG}]"
minivmac
