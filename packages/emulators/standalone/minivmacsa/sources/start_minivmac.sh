#!/bin/sh
# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present - Fewtarius

. /etc/profile

ARG=${1//[\\]/}
echo "[${ARG}]"
minivmac
