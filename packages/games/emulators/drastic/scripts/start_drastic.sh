#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)
. /etc/profile

if [ ! -d "/storage/.config/drastic/aarch64/drastic" ]; then
    mkdir -p "/storage/.config/drastic/aarch64"
    cd /storage/.config/drastic/aarch64
    cp /usr/config/drastic/drastic.tar.gz drastic.tar.gz
    tar -xvf drastic.tar.gz
    rm drastic.tar.gz
fi

if [ ! -d "/storage/.config/drastic/aarch64/drastic/config" ]; then
  mkdir -p /storage/.config/drastic/aarch64/drastic/config
  cp /usr/config/drastic/drastic.cfg /storage/.config/drastic/aarch64/drastic/config/drastic.cfg
fi

cd /storage/.config/drastic/aarch64/drastic/

./drastic "$1"
clear
