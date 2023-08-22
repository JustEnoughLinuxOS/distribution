&nbsp;&nbsp;<img src="https://raw.githubusercontent.com/JustEnoughLinuxOS/distribution/dev/distributions/JELOS/logos/jelos-logo.png" width=192>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[![Latest Version](https://img.shields.io/github/release/JustEnoughLinuxOS/distribution.svg?color=5998FF&label=latest%20version&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/releases/latest) [![Activity](https://img.shields.io/github/commit-activity/m/JustEnoughLinuxOS/distribution?color=5998FF&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/commits) [![Pull Requests](https://img.shields.io/github/issues-pr-closed/JustEnoughLinuxOS/distribution?color=5998FF&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/pulls) [![Discord Server](https://img.shields.io/discord/948029830325235753?color=5998FF&label=chat&style=flat-square)](https://discord.gg/seTxckZjJy)
#
# Network Play

RetroArch network play for up to 4 players is available across all WIFI enabled devices supported by JELOS.  Before continuing, please make sure that all devices are updated to the same version of the operating system.

## Enabling Network Play
Before netplay is available, it must be enabled on each participating device.

* Select Games Settings -> Netplay Settings
  * NetPlay -> Enabled
  * Index Games

## LAN based Network Play
Using this feature is simple.  For LAN based play, connect your devices to your WIFI network.  A minimum of one host and one client are required for play.

### Local LAN Play (HOST)
* Select Network Settings.
  * Disable Local Play Mode.
  * Select 1 (Host).
* Choose a game and press Y.
  * Select Netplay Options.
    * Select Host a Netplay Session.

### Local LAN Play (CLIENTS)
* Select Network Settings.
  * Disable Local Play Mode.
  * Select 2-4 (Clients).
* Choose a game and press Y.
  * Select Netplay Options.
    * Select Connect to a Netplay Session.

## Device to Device Network Play
Device to device connections will automatically generate and connect to a local WIFI network.  As with LAN based play, one host and one client are required for play.  Using the same version of JELOS on each device is REQUIRED or devices will not connect.  Device to device connections are intended for local play only, retroAchievements, scraping, and system updates will not be available in this mode.

### Device to Device Play (HOST)
* Select Network Settings.
  * Enable Local Play Mode.
  * Select 1 (Host).
* Choose a game and press Y.
  * Select Netplay Options.
    * Select Host a Netplay Session.

### Device to Device Play (CLIENTS)
* Select Network Settings.
  * Enable Local Play Mode.
  * Select 2-4 (Clients).
* Choose a game and press Y.
  * Select Netplay Options.
    * Select Connect to a Netplay Session.

## GameBoy GameLink
JELOS supports GameLink play for GameBoy and GameBoy Color.  To use, on each device select the appropriate core for the game being started in advanced settings for the game, or for the system.

|Core|Features|
|----|----|
|TGBDual * Recommended|Support for multiplayer GameLink play, including battle/trading."|
|Gambatte|Support for multiplayer GameLink play.|
