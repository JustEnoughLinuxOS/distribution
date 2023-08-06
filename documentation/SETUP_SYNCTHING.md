# Syncthing
Syncthing is a tool that lets you synchronize the contents of folders across multiple devices. It is different from cloud storage in that devices are updated directly with the latest changes from their peer(s) whenever they are online at the same time.
Some things you can use it for with JELOS:
* Keep your game library synchronized between your computer and JELOS device(s),
* Keep all your handhelds synchronized (including those that run Android),
* Copy savegames as they are created and seamlessly continue playing on another device,
* Keep a copy of your configuration files for easier editing.

## Setup

### Setup on JELOS
* Make sure you are connected to a WiFi network before continuing.
* Go to "Network Settings" and set "Enable Syncthing" to "on". Make a note of your device's IP address, as well as the root password in the System Settings menu.
* On a computer or mobile device in the same network, open a browser and point it to "http://a.b.c.d:8384" where "a.b.c.d" is the IP address of your JELOS device.
* When prompted for a user name and password, enter "root" as user and the password you noted earlier.
* You should now be directed to a configuration page running on your JELOS device - we'll come back to this shortly.

### Setup on Peer(s)
* Install Syncthing on the device or computer that you want to synchronize with your JELOS device. If your other device also runs JELOS, simply repeat the above steps. Otherwise go to https://syncthing.net to download Syncthing for your platform. You may also find it in your Linux distribution's package manager, the Android Play Store, etc. Generally it is not required to install the same version of Syncthing on all devices. You can synchronize a folder across any number of peers.

### Connecting Folders
1. Go to the web interface of your JELOS device (see above). Don't worry about notices about upgrading or the file system being read-only, nothing you can do.
(Note: You can also go to the web interface of any of the peers, it'll work the same - but for this documentation it is assumed that you're on a JELOS device.)
2. Under "Remote Devices", click "Add Remote Device". Enter the Device ID of the peer you want to synchronize with. If the remote is in the same network as your JELOS device the ID will be shown automatically. Otherwise, you'll find it in the remote's web interface by clicking "Actions" at the top and then "Show ID". Give the device a name if you like.
3. In the "Folders" section, click "Add Folder". In the popup window that opens, set a label and specify the path on the device (e.g. /storage/roms). This is the folder you will be sharing with other peers.
4. In the same popup window, go to the "Sharing" tab and select the remote device you just set up. Optionally, go to the "Ignore Patterns" tab and configure those. Click "Save" to close the window.
5. On the remote's interface you should receive a popup that a new device wants to connect. Click "Add Device" and then "Save" to accept. It should now show up under "Remote Devices".
6. Still on the remote, you should receive a new popup saying that the JELOS device wants to share a folder. Click "Add", then in the popup window, specify the path to an empty local folder to store the synchronized contents. Click "Save".
7. The folder should now be copied from the JELOS device to the remote.

### Adding more Peers
* To share the folder with more peers, first follow step 2 on your JELOS device to add another remote.
* Find the folder you want to add another peer to and click "Edit".
* In the popup window, go to the "Sharing" tab. The new remote should appear as an option. Select it and then click "Save".
* Follow steps 5 and 6 on the new remote to connect the folder.

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

### Synchronizing with Android
* For Android-based handhelds people seem to be recommending the [Syncthing-Fork from F-Droid](https://f-droid.org/en/packages/com.github.catfriend1.syncthingandroid).
* Keeping Syncthing running in the background may severely impact your battery life and reduce standby time. Check out [these tips](https://github.com/Catfriend1/syncthing-android/wiki/Info-on-battery-optimization-and-settings-affecting-battery-usage) to help you balance battery life and synchronization times.
* Using cross-platform versions of emulators is much more likely to introduce incompatibilities so be extra careful when syncing savegames.

## Further Documentation
For any questions and advanced configuration, be sure to check out the full documentation at https://docs.syncthing.net/index.html.
