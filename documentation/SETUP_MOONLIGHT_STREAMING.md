&nbsp;&nbsp;<img src="https://raw.githubusercontent.com/JustEnoughLinuxOS/distribution/dev/distributions/JELOS/logos/jelos-logo.png" width=192>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[![Latest Version](https://img.shields.io/github/release/JustEnoughLinuxOS/distribution.svg?color=5998FF&label=latest%20version&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/releases/latest) [![Activity](https://img.shields.io/github/commit-activity/m/JustEnoughLinuxOS/distribution?color=5998FF&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/commits) [![Pull Requests](https://img.shields.io/github/issues-pr-closed/JustEnoughLinuxOS/distribution?color=5998FF&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/pulls) [![Discord Server](https://img.shields.io/discord/948029830325235753?color=5998FF&label=chat&style=flat-square)](https://discord.gg/seTxckZjJy)
#

# Using Moonlight Game Streaming

JELOS now supports Moonlight Game Streaming, which allows to connect to your local computer running [Moonlight](https://moonlight-stream.org/) and stream AAA games.

## Setup Moonlight on your local PC
Please follow standard guide to setup Moonlight on your home PC, [link](https://github.com/moonlight-stream/moonlight-docs/wiki/Setup-Guide).

## Setup Moonlight in JELOS
The setup requires pairing with your local PC running Moonlight and then populating Moonlight Streaming tab with all your games. After those are completed, you can select an individual game to start streaming.

### Pair with your local PC
* On your JELOS device press "start" button to go into Emulation Station Main Menu
* Select "MOONLIGHT GAME STREAMING" submenu
* Please note the "PAIRING PIN" at the bottom of the window
* You can also specify "SERVER IP" address, but it should be detected automatically
* Select "PAIR WITH SERVER" option
* Now, go to the local PC and enter PIN to continue the pairing process
* You should see a confirmation message on your device
* The paring process should complete

After pairing was successful, select "UPDATE MOONLIGHT GAMES" option. This should query the server for the list of all games and populate Moonlight Streaming tab in Emulation Station.

## Play Games
Find Moonlight Game Streaming tab in Emulation Station. Select the game you want to play. The game should start and you should be able to interact with it.

## Remote Playing over internet
* The easiest option is to add your device to your Tailscale network with your local PC, [link](https://github.com/JustEnoughLinuxOS/distribution/wiki/Tailscale-VPN).
* Moonlight allows to open several ports to connect to the local PC to stream over the internet. Setup might be somewhat complicated.
* Another option is to use [WireGuard VPN](https://github.com/JustEnoughLinuxOS/distribution/wiki/WireGuard-VPN) to setup the connection with the device. This approach requires only a single open port, but it requires WireGuard server to be running on your local network.
