&nbsp;&nbsp;<img src="https://raw.githubusercontent.com/JustEnoughLinuxOS/distribution/dev/distributions/JELOS/logos/jelos-logo.png" width=192>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[![Latest Version](https://img.shields.io/github/release/JustEnoughLinuxOS/distribution.svg?color=5998FF&label=latest%20version&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/releases/latest) [![Activity](https://img.shields.io/github/commit-activity/m/JustEnoughLinuxOS/distribution?color=5998FF&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/commits) [![Pull Requests](https://img.shields.io/github/issues-pr-closed/JustEnoughLinuxOS/distribution?color=5998FF&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/pulls) [![Discord Server](https://img.shields.io/discord/948029830325235753?color=5998FF&label=chat&style=flat-square)](https://discord.gg/seTxckZjJy)
#
Just Enough Linux Operating System (JELOS) is an immutable Linux distribution for handheld gaming devices developed by a small community of enthusiasts.  Our goal is to produce an operating system that has the features and capabilities that we need, and to have fun as we develop it.

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

## Flashing
* Download the latest [version of JELOS](https://github.com/JustEnoughLinuxOS/distribution/releases) (.img.gz) for your device.
* Decompress the image.
* Write the image to an SDCARD using an imaging tool.  Common imaging tools include [Balena Etcher](https://www.balena.io/etcher/), [Raspberry Pi Imager](https://www.raspberrypi.com/software/), and [Win32 Disk Imager](https://sourceforge.net/projects/win32diskimager/).  If you're skilled with the command line, dd works fine too.

## Installation
* JELOS includes an installation tool.  The installation tool can be found in the tools menu.

## Upgrading
* Download and install the update online via the System Settings menu.
* Download the latest [version of JELOS](https://github.com/JustEnoughLinuxOS/distribution/releases) (.tar) for your device.
* Copy the update to your device over the network to your device's update share.
* Reboot the device, and the update will begin automatically.

## Network Access
* External services are disabled by default in stable builds.  When enabled, the username for ssh and samba access is "root".  The root password is generated during every boot, it can be found in the System Settings menu.

## Documentation
* [Home](https://github.com/JustEnoughLinuxOS/distribution/wiki)
* [Donating to JELOS](https://github.com/JustEnoughLinuxOS/distribution/wiki/Donating-to-JELOS)
* [Frequently asked Questions](https://github.com/JustEnoughLinuxOS/distribution/wiki/Frequently-Asked-Questions)
* [HotKeys](https://github.com/JustEnoughLinuxOS/distribution/wiki/Hotkeys)
* [Emulators and Game Engines](https://github.com/JustEnoughLinuxOS/distribution/wiki/JELOS-emulators-and-game-engines)
* [Moonlight Game Streaming](https://github.com/JustEnoughLinuxOS/distribution/wiki/Moonlight-Game-Streaming)
* [Performance and Battery Life Optimizations](https://github.com/JustEnoughLinuxOS/distribution/wiki/Performance-and-Battery-Life-Optimizations)
* [Using Cloud Drives](https://github.com/JustEnoughLinuxOS/distribution/wiki/Using-Cloud-Drives)
* [Tailscale VPN](https://github.com/JustEnoughLinuxOS/distribution/wiki/Tailscale-VPN)
* [Wireguard VPN](https://github.com/JustEnoughLinuxOS/distribution/wiki/WireGuard-VPN)

## Contributing
* [Developing and Building JELOS](https://github.com/JustEnoughLinuxOS/distribution/blob/dev/BUILDING.md)

## Credits
Like any Linux distribution, this project is not the work of one person.  It is the work of many persons all over the world who have developed the open source bits without which this project could not exist.  Special thanks to CoreELEC, LibreELEC, and to developers and contributors across the open source community.

