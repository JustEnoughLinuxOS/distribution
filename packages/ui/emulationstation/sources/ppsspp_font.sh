#!/bin/sh

if [ -z "$1" ]
then
    cp -f /usr/config/ppsspp/assets/orig.jpn0.pgf /storage/.config/ppsspp/assets/flash0/font/jpn0.pgf
    cp -f /usr/config/ppsspp/assets/orig.kr0.pgf /storage/.config/ppsspp/assets/flash0/font/kr0.pgf
else
    cp -f /usr/config/ppsspp/assets/patch.jpn0.pgf /storage/.config/ppsspp/assets/flash0/font/jpn0.pgf
    cp -f /usr/config/ppsspp/assets/patch.kr0.pgf /storage/.config/ppsspp/assets/flash0/font/kr0.pgf
fi
