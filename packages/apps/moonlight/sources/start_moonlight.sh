#!/bin/bash

. /etc/profile
set_kill set "moonlight"
QT_QPA_PLATFORM=wayland moonlight
