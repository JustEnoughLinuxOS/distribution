# JELOS - Just enough Linux Operating System
Just Enough Linux Operating System (JELOS) is a simple Linux distribution for ARM based devices that specializes in handhelds.  My goal is to build an operating system that has the features and capabilities that I need, and to have fun building it.

## Features
* Supports the Anbernic RG552 handheld.
* A 64bit Operating System.
* Supports FAT32, ExFAT, and EXT4 file systems.
* Filesystem compatibility with Android

## Licenses
JELOS is a Linux distribution that is made up of many open-source components.  Components are provided under their respective licenses.  This distribution includes components licensed for non-commercial use only.

### JELOS Branding
JELOS branding and images are licensed under a [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License](https://creativecommons.org/licenses/by-nc-sa/4.0/).

#### You are free to
* Share — copy and redistribute the material in any medium or format
* Adapt — remix, transform, and build upon the material

#### Under the following terms
* Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
* NonCommercial — You may not use the material for commercial purposes.
* ShareAlike — If you remix, transform, or build upon the material, you must distribute your contributions under the same license as the original.

### JELOS Software
Copyright 2021-present Fewtarius

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

## Installation
* Download the latest [version of JELOS](https://github.com/JustEnoughLinuxOS/distribution/releases) (.img.gz) for your device.
* Decompress the image.
* Write the image to an SDCARD using an imaging tool.  Common imaging tools include [Balena Etcher](https://www.balena.io/etcher/), [Raspberry Pi Imager](https://www.raspberrypi.com/software/), and [Win32 Disk Imager](https://sourceforge.net/projects/win32diskimager/).  If you're skilled with the command line, dd works fine too.

## Upgrading
* Download the latest [version of JELOS](https://github.com/JustEnoughLinuxOS/distribution/releases) (.tar or .img.gz) for your device.
* Copy the update to your device over the network or to the sdcard's update folder.
* Reboot the device, and the update will begin automatically.

## Network Access
* The username for ssh and samba access is "root".  The root password is generated during every boot, it can be found in the Network Settings menu.

## Credits
Like any Linux distribution, this project is not the work of one person.  It is the work of many persons all over the world who have developed the open source bits without which this project could not exist.  Special thanks to 351ELEC, EmuELEC, CoreELEC, LibreELEC, Anbernic, and developers across the ARM handheld community.

## Frequently Asked Questions
* Does JELOS offer any support?
  * No. JELOS is something that I develop for fun, it is provided as-is.  If you require a distribution with support, I recommend you choose a community supported distribution instead.
* Do you plan to add additional ports, software, or emulators?
  * I add things to JELOS as I have an itch to scratch. The community has updated PortMaster to work with JELOS.
* What about N64, Dreamcast, Saturn, Jaguar, PSP, etc on the 552?
  * Those platforms perform best in Android on the 552, and I have no interest in them.  I recommend that you use Android instead for those.
* Will you support my device?
  * If you send me a device and source code, I'll consider it.
* How can I disable root password rotation?
  * SSH to the handheld and run the following commands.
    * ```set_setting rotate.root.password 0```
    * ```passwd root```
    * ```smbpasswd root```
  * Alternatively, copy your ssh key with ssh-copy-id, and leave rotation enabled.
    * ```ssh-copy-id root@jelos```
* I want to add games to SD Card 1 and see them in my EmulationStation games list.
  * A custom facility has been added to JELOS to enable things such as this, to use it add a script to /storage/.config/autostart to create a bind mount and add your games to the directory on your primary SD card.  They will appear in ES after a restart of the ES service or a reboot.  To create a bind mount, use the example below, changing as necessary.
    * This example uses file name 001-bind.
    * ```#!/bin/bash```
    * ```mkdir -p /storage/roms/c64 /storage/c64 2>&1 >/dev/null```
    * ```mount --bind /storage/roms/c64 /storage/c64```
    * Make it executable with chmod. ```chmod 0755 /storage/.config/autostart/001-bind```
