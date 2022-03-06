&nbsp;&nbsp;<img src="https://raw.githubusercontent.com/JustEnoughLinuxOS/distribution/dev/distributions/JELOS/logos/jelos-logo.png" width=192>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[![Latest Version](https://img.shields.io/github/release/JustEnoughLinuxOS/distribution.svg?color=5998FF&label=latest%20version&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/releases/latest) [![Activity](https://img.shields.io/github/commit-activity/m/JustEnoughLinuxOS/distribution?color=5998FF&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/commits) [![Pull Requests](https://img.shields.io/github/issues-pr-closed/JustEnoughLinuxOS/distribution?color=5998FF&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/pulls) [![Discord Server](https://img.shields.io/discord/948029830325235753?color=5998FF&label=chat&style=flat-square)](https://discord.gg/seTxckZjJy)
#
Just Enough Linux Operating System (JELOS) is a simple Linux distribution for ARM based devices that specializes in handhelds.  My goal is to build an operating system that has the features and capabilities that I need, and to have fun building it.

## Features
* Supports the Anbernic RG552 handheld.
* A 64bit Operating System.
* Filesystem compatibility with Android.
* Utilizes the whole SDCARD for EXT4 storage.
* Supports FAT32, ExFAT, and EXT4 file systems on the second card.
* Provides overclock and cooling profiles.
* Supports 2.4GHz and 5GHz 802.11 A/B/G/N/AC WIFI.
* Includes RetroArch, a variety of cores, Stand Alone Emulators, as well as PortMaster.
* Maintained by a small but growing community of contributors.

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

## RetroArch Hotkeys
* Hotkey Enable: Select (Hold)
  * Exit: Start (Press Twice)
  * Menu: X
  * Show/Hide FPS: Y
  * Save State: R1
  * Load State: L1
  * Rewind: L2
  * Fast-Forward Toggle: R2

## Credits
Like any Linux distribution, this project is not the work of one person.  It is the work of many persons all over the world who have developed the open source bits without which this project could not exist.  Special thanks to 351ELEC, EmuELEC, CoreELEC, LibreELEC, Anbernic, and developers across the ARM handheld community.

## Frequently Asked Questions
* Does JELOS offer any formal support?
  * No. JELOS is something that we develop for fun, it is provided as-is.  There are a variety of avenues to seek community help, but this is a tinkerer's distribution so you may need to get your hands dirty to solve your problems.
* Do you plan to add additional ports, software, or emulators?
  * I add things to JELOS as I have an itch to scratch, as does the community of contributors.  If you would like to add something to JELOS, pull requests are welcomed.
* What about N64, Dreamcast, Saturn, Jaguar, PSP, etc on the 552?
  * Those platforms perform best in Android on the 552, and I have no interest in them.  I recommend that you use Android instead for those.
* Will you support my device?
  * If you send me a device and source code, I'll consider it.
* I'm using brand-y microSD and after flashing it partitions, reboots, and hangs.
  * When this happens the indicator is a short vibration like it's restarting normally but the power LED does not turn on.  Press reset, and it will continue normally.
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
    * If /storage/.config/autostart does not exist, make it with mkdir. ```mkdir /storage/.config/autostart```
    * ```#!/bin/bash```
    * ```mkdir -p /storage/roms/c64 /storage/c64 2>&1 >/dev/null```
    * ```mount --bind /storage/roms/c64 /storage/c64```
    * Make it executable with chmod. ```chmod 0755 /storage/.config/autostart/001-bind```
