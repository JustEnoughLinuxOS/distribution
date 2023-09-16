&nbsp;&nbsp;<img src="https://raw.githubusercontent.com/JustEnoughLinuxOS/distribution/dev/distributions/JELOS/logos/jelos-logo.png" width=192>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[![Latest Version](https://img.shields.io/github/release/JustEnoughLinuxOS/distribution.svg?color=5998FF&label=latest%20version&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/releases/latest) [![Activity](https://img.shields.io/github/commit-activity/m/JustEnoughLinuxOS/distribution?color=5998FF&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/commits) [![Pull Requests](https://img.shields.io/github/issues-pr-closed/JustEnoughLinuxOS/distribution?color=5998FF&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/pulls) [![Discord Server](https://img.shields.io/discord/948029830325235753?color=5998FF&label=chat&style=flat-square)](https://discord.gg/seTxckZjJy)
#
# Performance and Battery Life Optimizations

## Optimizing Performance
Optimizing for performance will have significant impact on battery life, however it will provide the best experience for more demanding emulators.

### Recommended Global Settings

#### AMD / Intel based devices
|Enabled CPU Threads|Cooling Profile|Max TDP|Scaling Governor|Enhanced Power Saving|WIFI Power Saving|
|----|----|----|----|----|
|All|Moderate|18w|Balanced|Off|Off|

#### ARM based devices
|Enabled CPU Threads|Cooling Profile|Scaling Governor|Enhanced Power Saving|WIFI Power Saving|
|----|----|----|----|----|
|All|Moderate<sup>1</sup>|Balanced|Off|Off|

> Note: It's recommended to reboot the device after disabling Enhanced Power Saving.

## Optimizing Battery Life
JELOS includes an `Enhanced Power Saving` mode which is available in the `System Settings` menu.  This option provides a variety of sub options that when enabled tune your device for optimal battery life without immediately sacrificing performance.

|Feature|Function|May Affect Stability|
|----|----|----|
|CPU Power Saving|Tunes the CPU/SoC to preference battery life over performance.|No|
GPU Performance Profile<sup>1</sup>|User configurable to force the GPU into the preferred performance state|No|
Audio Power Saving|Enables the audio device to operate in a low power mode.|No|
PCIE Active State Power Management|Forces a low power state for PCI and PCIe connections.|Yes|
Enable Wake Events|Enables PCI wakeup signalling to allow devices to enter low power states.|Yes|
Runtime Power Management|Enables USB idle power management, and configures usb devices to autosuspend.|Yes|

### Recommended Settings For Optimal Battery Life
Enable Enhanced Power Saving, and enable all options.  If the device has undesired behavior, disable the options that may effect stability and reboot the device.

#### AMD / Intel based devices
|Enabled CPU Threads|Cooling Profile|Max TDP|Scaling Governor|GPU Performance Profile|Enhanced Power Saving|WIFI Power Saving|
|----|----|----|----|----|----|----|
|4|Quiet<sup>1</sup>|4.5w|Powersave|Battery Focus|On|On|

#### ARM based devices

|Enabled CPU Threads|Cooling Profile|CPU Governor|Enhanced Power Saving|WIFI Power Saving|
|----|----|----|----|----|----|
|4|Quiet<sup>1</sup>|Powersave|Battery Focus|On|On|

#### AMD / Intel Recommended Settings Per System

|Manufacturer|System|Enabled CPU Threads|Cooling Profile|Max TDP|Scaling Governor|GPU Performance Profile<sup>1</sup>|Enhanced Power Saving|WIFI Power Saving|
|----|----|----|----|----|----|----|----|
|Microsoft|Xbox|6|Quiet|22w|Schedutil|Balanced|On|On|
|Nintendo|GameCube, Wii|4|Quiet|15W|Schedutil|Balanced|On|On|
|Nintendo|Wii U, Switch|6|Moderate|22w|Schedutil|Balanced|On|On|
|Sony|PS2|4|Quiet|18w|Schedutil|Balanced|On|
|Sony|PSP|2|Quiet|9w|Powersave|Battery Focus|On|On|

#### ARM Devices
|Manufacturer|System|Enabled CPU Threads|Cooling Profile|Scaling Governor|Enhanced Power Saving|WIFI Power Saving|
|----|----|----|----|----|----|
|Nintendo|64|All|Moderate<sup>1</sup>|Performance|On|On|
|Nintendo|GameCube, Wii|All|Moderate<sup>1</sup>|Performance|On|On|
|Sega|Saturn, Dreamcast|All|Moderate<sup>1</sup>|Performance|On|On|
|Sony|PSP|All|Moderate<sup>1</sup>|Performance|On|On|

Note: Emulating 6th generation and newer consoles will result in lower runtimes as they require significant power draw.

> <sup>1</sup> Only available when "Enhanced Power Saving" is enabled or if the feature is supported.
