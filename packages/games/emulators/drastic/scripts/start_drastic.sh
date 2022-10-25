#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)
. /etc/profile

if [ ! -d "/storage/.config/drastic/aarch64/drastic" ]; then

  echo -e "=> ${OS_NAME} DRASTIC INSTALLATION"
  echo -e "\nChecking for internet connection..."

  INETUP=$(ping -c1 -w1 www.google.com >/dev/null 2>&1)
  if [ $? == 0 ]
  then
    mkdir -p "/storage/.config/drastic/aarch64"
    cd /storage/.config/drastic/aarch64

    echo -e "\nFetching Drastic..."

    curl -Lo drastic.tar.gz https://github.com/brooksytech/JelosAddOns/raw/main/drastic.tar.gz

    echo -e "\nExtracting...\n"
    tar -xvf drastic.tar.gz

    rm drastic.tar.gz

    if [ ! -d "/storage/.config/drastic/aarch64/drastic/config" ]; then
      mkdir -p /storage/.config/drastic/aarch64/drastic/config
      cp /usr/config/drastic/drastic.cfg /storage/.config/drastic/aarch64/drastic/config/drastic.cfg
    fi

    clear

  else
    echo -e "Please connect to the internet before starting Drastic for the first time..." 2>&1

    sleep 5
    clear
    exit 1
  fi

fi

if [ ! -d "/storage/.config/drastic/aarch64/drastic/config" ]; then
  mkdir -p /storage/.config/drastic/aarch64/drastic/config
  cp /usr/config/drastic/drastic.cfg /storage/.config/drastic/aarch64/drastic/config/drastic.cfg
fi

cd /storage/.config/drastic/aarch64/drastic/

./drastic "$1"
clear
