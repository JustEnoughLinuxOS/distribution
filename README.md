&nbsp;&nbsp;<img src="https://raw.githubusercontent.com/JustEnoughLinuxOS/distribution/dev/distributions/JELOS/logos/jelos-logo.png" width=192>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[![Latest Version](https://img.shields.io/github/release/JustEnoughLinuxOS/distribution.svg?color=5998FF&label=latest%20version&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/releases/latest) [![Activity](https://img.shields.io/github/commit-activity/m/JustEnoughLinuxOS/distribution?color=5998FF&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/commits) [![Pull Requests](https://img.shields.io/github/issues-pr-closed/JustEnoughLinuxOS/distribution?color=5998FF&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/pulls) [![Discord Server](https://img.shields.io/discord/948029830325235753?color=5998FF&label=chat&style=flat-square)](https://discord.gg/seTxckZjJy)
#
Just Enough Linux Operating System (JELOS) is an immutable Linux distribution for handheld gaming devices developed by a small community of enthusiasts.  Our goal is to produce an operating system that has the features and capabilities that we need, and to have fun as we develop it.

## Device Support
JELOS supports a variety of ARM and Intel/AMD based devices<sup>1</sup>.  
| Manufacturer | Device | CPU / Architecture | Kernel | GL driver | Interface |
|--|--|--|--|--|--|
|Anbernic| RG351P/M | Rockchip RK3326 (ARM) | Mainline Linux | Panfrost | Weston + EmulationStation|
|Anbernic| RG353P<sup>2</sup> | Rockchip RK3566 (ARM) | Rockchip BSP 4.19 | Mali | KMS/DRM + EmulationStation|
|Anbernic| RG353M<sup>2</sup> | Rockchip RK3566 (ARM) | Rockchip BSP 4.19 | Mali | KMS/DRM + EmulationStation|
|Anbernic| RG353V<sup>2</sup> | Rockchip RK3566 (ARM) | Rockchip BSP 4.19 | Mali | KMS/DRM + EmulationStation|
|Anbernic| RG353VS<sup>2</sup> | Rockchip RK3566 (ARM) | Rockchip BSP 4.19 | Mali | KMS/DRM + EmulationStation|
|Anbernic| RG503 | Rockchip RK3566 (ARM) | Rockchip BSP 4.19 | Mali | KMS/DRM + EmulationStation|
|Anbernic| RG552 | Rockchip RK3399 (ARM) | Mainline Linux | Panfrost | Weston + EmulationStation|
|Anbernic|Win600|AMD Athlon Silver 3050e (x86_64)|Mainline Linux|Radeonsi|Weston + EmulationStation|
|Atari|VCS|AMD Ryzen R1606G (x86_64)|Mainline Linux|Radeonsi|Weston + EmulationStation|
|AYANEO<sup>3</sup>|Air / Air Pro|Amd Ryzen 5 5560U / AMD Ryzen 7 5825U (x86_64)|Mainline Linux|Radeonsi|Weston + EmulationStation|
|AYANEO<sup>3</sup>|Air Plus|Amd Ryzen 7 6800U / (x86_64)|Mainline Linux|Radeonsi|Weston + EmulationStation|
|AYANEO<sup>3</sup>|AYANEO 2|Amd Ryzen 7 6800U / (x86_64)|Mainline Linux|Radeonsi|Weston + EmulationStation|
|GPD|Win Max 2 (2022)|Amd Ryzen 7 6800U / (x86_64)|Mainline Linux|Radeonsi|Weston + EmulationStation|
|Hardkernel| Odroid Go Advance | Rockchip RK3326 (ARM) | Mainline Linux | Panfrost | Weston + EmulationStation|
|Hardkernel| Odroid Go Super | Rockchip RK3326 (ARM) | Mainline Linux | Panfrost | Weston + EmulationStation|
|Hardkernel|Odroid Go Ultra|Amlogic S922X / Mali G52 M6 (ARMv8-A)|Mainline Linux|Mali|Weston + EmulationStation|
|Indiedroid|Nova|Rockchip RK3588S / Mali G610 (ARMv8-A)|Rockchip 5.10 BSP Linux|Panfrost|Weston + EmulationStation|
|Orange Pi|Orange Pi 5|Rockchip RK3588S / Mali G610 (ARMv8-A)|Rockchip 5.10 BSP Linux|Panfrost|Weston + EmulationStation|
|Powkiddy|RGB10 Max 3 Pro|Amlogic A311D / Mali G52 M4 (ARMv8-A)|Mainline Linux|Mali|Weston + EmulationStation|
|Powkiddy| RK2023 | Rockchip RK3566 (ARM) | Rockchip BSP 4.19 | Mali | KMS/DRM + EmulationStation |
|Powkiddy| x55 | Rockchip RK3566 (ARM) | Rockchip BSP 4.19 | Mali | KMS/DRM + EmulationStation |

> <sup>1</sup> While not technically supported, JELOS is known to work well on a variety of generic x86_64 devices including gaming PCs, mini PCs, and laptop computers.

> <sup>2</sup> Anbernic RG353P/M/V/VS devices with both v1 and v2 displays are supported.  RG353PS will not be supported.

> <sup>3</sup> To boot JELOS on Ayaneo devices, hold LC and volume up and press the power button, continue holding "LC" and volume up until the Ayaneo logo appears.  Select the storage device with JELOS from the boot menu using the Ayaneo button, and then press volume up to boot the distribution.

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

### Documentation For Developers
* [Adding Hardware Quirks](/documentation/DEVEL_ADD_HARDWARE_QUIRKS.md)
* [Building The Distribution](/documentation/DEVEL_BUILDING_JELOS.md)
* [Contributor Code of Conduct](/CODE_OF_CONDUCT.md)
* [Contributing to JELOS](/CONTRIBUTING.md)
* [Creating Packages](/documentation/DEVEL_CREATING_PACKAGES.md)
* [Pull Request Template](/PULL_REQUEST_TEMPLATE.md)

### Documentation For Everyone
* [Installation and Device Support](https://github.com/JustEnoughLinuxOS/distribution/tree/main#readme)
* [Device Specific Documentation](/documentation/PER_DEVICE_DOCUMENTATION)
* [Donating to JELOS](/documentation/GENERAL_DONATING_TO_JELOS.md)
* [Frequently Asked Questions](/documentation/GENERAL_FREQUENTLY_ASKED_QUESTIONS.md)
* [Hotkeys and Button Codes](/documentation/GENERAL_HOTKEYS_AND_BUTTON_CODES.md)

### Using JELOS
* [Setting Up Cloud Drives](/documentation/SETUP_CLOUD_DRIVES.md)
* [Game Engines and Launch Files](/documentation/SETUP_GAME_ENGINES_AND_LAUNCH_FILES.md)
* [Configuring Moonlight Streaming](/documentation/SETUP_MOONLIGHT_STREAMING.md)
* [Setting Up P2P Networking With ZeroTier](/documentation/SETUP_P2P_ZEROTIER.md)
* [Configure TailScale VPN](/documentation/SETUP_VPN_TAILSCALE.md)
* [Setting Up Wireguard VPN](/documentation/SETUP_VPN_WIREGUARD.md)

## Credits
Like any Linux distribution, this project is not the work of one person.  It is the work of many persons all over the world who have developed the open source bits without which this project could not exist.  Special thanks to CoreELEC, LibreELEC, and to developers and contributors across the open source community.

