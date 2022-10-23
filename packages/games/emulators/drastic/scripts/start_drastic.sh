#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)
. /etc/profile

if [ ! -d "/storage/.config/drastic/aarch64/drastic" ]; then

echo "Drastic emulator not installed." 2>&1
echo "Checking for internet connection" 2>&1

INETUP=$(ping -c1 -w1 www.google.com >/dev/null 2>&1)
if [ $? == 0 ]
then
 echo "Downloading Drastic" 2>&1
 mkdir -p "/storage/.config/drastic/aarch64"
  cd /storage/.config/drastic/aarch64

  wget https://github.com/brooksytech/JelosAddOns/raw/main/drastic.tar.gz

  tar -xvf drastic.tar.gz

  rm drastic.tar.gz

  if [ ! -d "/storage/.config/drastic/aarch64/drastic/config" ]; then
    mkdir -p /storage/.config/drastic/aarch64/drastic/config
    cp /usr/config/drastic/drastic.cfg /storage/.config/drastic/aarch64/drastic/config/drastic.cfg
  fi

  cd /storage/.config/drastic/aarch64/drastic/

  ./drastic "$1"

else
 echo "Please connect to the internet first." 2>&1
fi

sleep 5
clear

else

if [ ! -d "/storage/.config/drastic/aarch64/drastic/config" ]; then
  mkdir -p /storage/.config/drastic/aarch64/drastic/config
  cp /usr/config/drastic/drastic.cfg /storage/.config/drastic/aarch64/drastic/config/drastic.cfg
fi

cd /storage/.config/drastic/aarch64/drastic/

./drastic "$1"

fi
