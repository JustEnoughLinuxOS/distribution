#!/bin/bash

. /etc/profile

jslisten set "mpv"
/usr/bin/mpv --input-ipc-server=/tmp/mpvsocket "${1}"
exit 0
