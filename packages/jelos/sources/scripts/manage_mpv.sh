#!/bin/bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present ShantiGilbert, RedWolfTech, Fewtarius

function sendkey() {
  echo '{"command":["keypress", "'${1}'"]}' | socat - "/tmp/mpvsocket"
}

case "$1" in
    "pause")
        sendkey "p"
    ;;
    "changeaudio")
        sendkey "#"
    ;;
    "changesub")
        sendkey "j"
    ;;
    "showosd")
        sendkey "O"
    ;;
    "back5s") 
        sendkey "LEFT"
    ;;
    "skip5s") 
        sendkey "RIGHT"
    ;;
    "back60s") 
        sendkey "DOWN"
    ;;
    "skip60s") 
        sendkey "UP"
    ;;
    "quit") 
        sendkey "Q"
    ;;
esac

