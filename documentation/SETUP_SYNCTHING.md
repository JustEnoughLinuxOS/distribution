# Syncthing
Syncthing is a tool that lets you synchronize the contents of folders across multiple devices. It is different from cloud storage in that devices are updated directly with the latest changes from their peer(s) whenever they are online at the same time.
In JELOS you may use it to:
* Keep your ROM library synchronized between your computer and JELOS device(s),
* Automatically copy savegames as they are created and seamlessly continue playing on another device,
* Keep a copy of your configuration files for easier editing,
* ...and lots more.

## Setup on JELOS
* Make sure you are connected to a WiFi network before continuing.
* Go to "Network Settings" and set "Enable Syncthing" to "on". Make a note of your device's IP address and the root password in the Network Settings menu.
* On a computer or mobile device in the same network, open a browser and point it to "a.b.c.d:8384" where "a.b.c.d" is the IP address of your JELOS device.
* When prompted for a user name and password, enter "root" as user and the password you noted earlier.
* You should now be directed to a configuration page running on your JELOS device - we'll come back to this shortly.

## Setup on Peer(s)
* Install Syncthing on the device or computer that you want to synchronize with your JELOS device. If your other device also runs JELOS, simply repeat the above steps. Otherwise go to https://syncthing.net to download Syncthing for your platform. You may also find it in your Linux distribution's package manager, the Android Play Store, etc. Generally it is not required to install the same version of Syncthing on all devices. You can synchronize a folder across any number of peers.
* (TBD)

## Things to Keep in Mind

### Syncthing is not a cloud storage
In order for devices to synchronize, they need to be online at the same time. Unless you have one peer that is always on, this is different from an online storage like Dropbox or Nextcloud. However, this behaviour can be emulated (no pun intended) by installing Syncthing on a cloud server or an always-on Raspberry Pi.

### Syncthing is not a backup
Folders are synchronized with other peers immediately as they come online at the same time - this includes changes and deletions! Be sure to make regular backups of your folders.

### Devices do not need to be on the same network
Syncthing uses relay servers to ensure communication between peers. This means that there does not need to be a direct connection between your devices, no port forwarding, etc - as soon as they are both online they will find each other and synchronize. Although file transfers are end-to-end encrypted when they are sent through relays, be aware of this if you plan on using Syncthing for anything more sensitive than your save files.

### Using Syncthing for Saves/States
Using Syncthing for savegames is great because it allows you to seamlessly play a game across multiple handhelds, or even other devices. For example, you can play a game of Super Mario 64 on your RG353 while on the go, then launch the game on a RetroPie or PC running RetroArch and your save game will be transferred automatically to be continued on the big screen. However, this comes with a few caveats.

RetroArch differentiates between *saves*, i.e. the battery or memory card storage featured in the original game, and *states*, i.e. the save state feature that is part of the emulator. While *saves* are often compatible across different versions of RetroArch cores, *states* tend to break more frequently. This means that if you create states with two incompatible versions of an emulator and they are synchronized, you may lose one of them.

* For maximum compatibility, make sure to use the same cores on all devices and update them at similar frequencies.
* RetroArch uses two separate folders for *saves* and *states*. This makes it easy to choose whether you want to synchronize only saves, states, or both.
* In the RetroArch settings under "Saving", you can tell RetroArch to sort saves and states into subfolders based on content directory or core name. It is highly recommended to make use of this to reduce the risk of accidentally overwriting an incompatible save or state.
* Make regular backups of your save folders.

(TBD)
For any questions and advanced configuration, be sure to check out the full documentation at https://docs.syncthing.net/index.html.
