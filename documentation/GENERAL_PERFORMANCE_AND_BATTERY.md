&nbsp;&nbsp;<img src="https://raw.githubusercontent.com/JustEnoughLinuxOS/distribution/dev/distributions/JELOS/logos/jelos-logo.png" width=192>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[![Latest Version](https://img.shields.io/github/release/JustEnoughLinuxOS/distribution.svg?color=5998FF&label=latest%20version&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/releases/latest) [![Activity](https://img.shields.io/github/commit-activity/m/JustEnoughLinuxOS/distribution?color=5998FF&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/commits) [![Pull Requests](https://img.shields.io/github/issues-pr-closed/JustEnoughLinuxOS/distribution?color=5998FF&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/pulls) [![Discord Server](https://img.shields.io/discord/948029830325235753?color=5998FF&label=chat&style=flat-square)](https://discord.gg/seTxckZjJy)
#
# Performance and Battery Life Optimizations

## Optimizing Performance
Optimizing for performance will have significant impact on battery life, however it will provide the best experience for more demanding emulators.  Begin by disabling `Enhanced Power Saving` in the `System Settings` menu.

### Recommended Global Settings

|Enabled CPU Threads|Cooling Profile|Max TDP|CPU Governor|GPU Power Savings Mode<sup>1</sup>|WIFI Power Saving|
|----|----|----|----|----|----|
|All|Moderate|18w|Performance|Unavailable|Off|

## Optimizing Battery Life
JELOS includes an `Enhanced Power Saving` mode which is available in the `System Settings` menu.  This mode tunes your device for power saving, but does not enable options that may affect performance.  The table below provides general recommendations to achieve the best possible battery life.  Additional adjustments may need to be made to individual emulators or games for the best balance of performance and battery life.

### Recommended Global Settings

|Enabled CPU Threads|Cooling Profile|Max TDP|CPU Governor|GPU Power Savings Mode<sup>1</sup>|WIFI Power Saving|
|----|----|----|----|----|----|
|2|Quiet|Default|Powersave|Low|On|

### Recommended Settings Per System
The table below provides recommended settings per system, however emulating newer systems will still have significant drain.

|Manufacturer|System|Enabled CPU Threads|Cooling Profile|Max TDP|CPU Governor|GPU Power Savings Mode<sup>1</sup>|WIFI Power Saving|
|----|----|----|----|----|----|----|----|
|Nintendo|GameCube, Wii|2|Quiet|Default|Schedutil|Auto|On|
|Nintendo|Wii U, Switch|6|Quiet|18w|Schedutil|Auto|On|
|Sony|PS2|4|Quiet|18w|Schedutil|Auto|On|
|Sony|PSP|2|Quiet|Default|Powersave|Auto|On|

> <sup>1</sup> Only available when "Enhanced Power Saving" is enabled.
