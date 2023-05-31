#!/bin/bash

if [ -z $1 ]
then
  echo "No parameter."
else
  PROJECT=PC DEVICE=AMD64 ARCH=x86_64 ./scripts/build $1
  PROJECT=Rockchip DEVICE=RK3588 ARCH=aarch64 ./scripts/build $1
  PROJECT=Rockchip DEVICE=RK3326 ARCH=aarch64 ./scripts/build $1
  PROJECT=Rockchip DEVICE=RK3566 ARCH=aarch64 ./scripts/build $1
  PROJECT=Amlogic DEVICE=S922X ARCH=aarch64 ./scripts/build $1
  echo "Yeah-"
fi
