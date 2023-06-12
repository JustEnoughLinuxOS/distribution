#!/bin/bash

jslisten set "mpv"jslisten set "mpv"
/usr/bin/mpv --input-ipc-server=/tmp/mpvsocket "${1}"
exit 0
