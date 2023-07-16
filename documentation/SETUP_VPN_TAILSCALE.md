&nbsp;&nbsp;<img src="https://raw.githubusercontent.com/JustEnoughLinuxOS/distribution/dev/distributions/JELOS/logos/jelos-logo.png" width=192>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[![Latest Version](https://img.shields.io/github/release/JustEnoughLinuxOS/distribution.svg?color=5998FF&label=latest%20version&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/releases/latest) [![Activity](https://img.shields.io/github/commit-activity/m/JustEnoughLinuxOS/distribution?color=5998FF&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/commits) [![Pull Requests](https://img.shields.io/github/issues-pr-closed/JustEnoughLinuxOS/distribution?color=5998FF&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/pulls) [![Discord Server](https://img.shields.io/discord/948029830325235753?color=5998FF&label=chat&style=flat-square)](https://discord.gg/seTxckZjJy)
#

# Tailscale quickstart
JELOS now supports Tailscale. Tailscale is a VPN service that makes the devices and applications you own accessible anywhere in the world, securely and effortlessly. It enables encrypted point-to-point connections using the open source [WireGuard](https://www.wireguard.com/) protocol, which means only devices on your private network can communicate with each other.

## Step 1: Sign up for Tailscale account
[Sign up for a Tailscale account](https://login.tailscale.com/start).

Tailscale requires a Single Sign-On (SSO) provider, so you’ll need a Google, Microsoft, GitHub, Okta, OneLogin, or other  [supported SSO identity provider](https://tailscale.com/kb/1013/sso-providers)  account to begin.

## Step 2: Add a PC to your Tailscale network

Tailscale helps you connect your devices together. For that to be possible, Tailscale needs to run on your PC.

Tailscale works seamlessly with Linux, Windows, macOS, Raspberry Pi, Android, Synology, and more. Download Tailscale and log in on the PC.

[Download Tailscale](https://tailscale.com/download/)

## Step 3: Add your device to your network

JELOS Emulation Station has customized UI with Tailscale support.

- Press "start" button to go into Emulation Station Main Menu.
- Select Network Settings submenu.
- Select "Tailscale VPN" and turn it on.
- Select "Back" button to exit setting dialog.

The initial connection to Tailscale will require authentication.

- Select Network Settings submenu again.
- You should see Tailscale authentication url. You need to type this url on your PC browser and authenticate.
- After login on PC is successful, Select "Tailscale VPN" and turn it on again.
- Select "Back" button to exit setting dialog.
- Tailscale VPN should be connected.

The magic of Tailscale happens when it’s installed on multiple devices. Add more of your devices and share Tailscale with your peers to grow your private network.

Add more machines to your network by repeating step 2, or 3, or by  [inviting others to join your network](https://tailscale.com/kb/1064/invite-team-members).

## Links
* Tailscale homepage [link](https://tailscale.com/)

