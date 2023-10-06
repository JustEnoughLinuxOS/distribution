#!/bin/bash

. /etc/profile
jslisten set "moonlight"
QT_QPA_PLATFORM=wayland moonlight
