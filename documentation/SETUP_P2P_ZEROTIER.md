&nbsp;&nbsp;<img src="https://raw.githubusercontent.com/JustEnoughLinuxOS/distribution/dev/distributions/JELOS/logos/jelos-logo.png" width=192>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[![Latest Version](https://img.shields.io/github/release/JustEnoughLinuxOS/distribution.svg?color=5998FF&label=latest%20version&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/releases/latest) [![Activity](https://img.shields.io/github/commit-activity/m/JustEnoughLinuxOS/distribution?color=5998FF&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/commits) [![Pull Requests](https://img.shields.io/github/issues-pr-closed/JustEnoughLinuxOS/distribution?color=5998FF&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/pulls) [![Discord Server](https://img.shields.io/discord/948029830325235753?color=5998FF&label=chat&style=flat-square)](https://discord.gg/seTxckZjJy)
#

# ZeroTier quickstart
JELOS now supports ZeroTier. ZeroTier allows you to build robust peer-to-peer networks, connetcting all of your devices together. It's very similar to [Tailscale](https://github.com/JustEnoughLinuxOS/distribution/wiki/Tailscale-VPN).

## Step 1: Sign up for ZeroTier account
[Sign up for a ZeroTier account](https://my.zerotier.com).

## Step 2: Add other devices to your ZeroTier network

You can add devices that you want connected to the ZeroTier network. One device can be connected to multiple networks, so you can even have different networks for different purposes.

It's most likely going to run everywhere you want it, since the software exists for OpenWRT, Desktop Linux, Windows, Android, etc.

[Download ZeroTier](https://www.zerotier.com/download)

## Step 3: Add your device to your network

JELOS Emulation Station has customized UI with ZeroTier support.

- Create a file called "zerotier-networks" in ```/storage/.config/zerotier-networks```, containing one network ID per line
- Press "start" button to go into Emulation Station Main Menu.
- Select Network Settings submenu.
- Select "ZeroTier VPN" and turn it on.
- Select "Back" button to exit setting dialog.

Don't forget to authenticate your device in the ZerTier [control panel](my.zerotier.com) after starting the service. It should show up on the webpage.

You can also use the traditional way of adding a network ID by using ```zerotier-cli join``` through SSH shell, but in this cae the zerotier-networks file shouldn't be present.

## Links
* ZeroTier homepage [link](https://zerotier.com/)
* Script used to add networks on start [link](https://github.com/JustEnoughLinuxOS/distribution/blob/dev/packages/network/zerotier-one/scripts/zerotier-join.sh)
