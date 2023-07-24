# Syncthing Setup
Syncthing is a tool that lets you synchronize the contents of folders across multiple systems. Rather than using cloud storage, devices are updated directly with the latest changes from their peer(s) whenever they are online at the same time.
In JELOS you may use it to:
* Keep your ROM library synchronized between your computer and JELOS device(s),
* Automatically copy savegames as they are created and seamlessly continue playing on another device (provided they're both using the same emulators),
* Keep a copy of your configuration files for easier editing,
* ...and lots more.

## Setup JELOS Device
* Make sure you are connected to a WiFi network before continuing.
* Go to "Network Settings" and set "Enable Syncthing" to "on". Make a note of your device's IP address and the root password in the Network Settings menu.
* On a computer or mobile device in the same network, open a browser and point it to "a.b.c.d:8384" where "a.b.c.d" is the IP address of your JELOS device.
* When prompted for a user name and password, enter "root" as user and the password you noted earlier.
* You should now be directed to a configuration page running on your JELOS device - we'll come back to this shortly.

## Setup Other Machine
* Install Syncthing on the device or computer that you want to synchronize with your JELOS device. If your other device also runs JELOS, simply repeat the above steps. Otherwise go to https://syncthing.net to download Syncthing for your platform. You may also find it in your Linux distribution's package manager, the Android Play Store, etc. Generally it is not required to install the same version of Syncthing on all devices.
* (TBD)

For any questions and advanced configuration, be sure to check out the full documentation at https://docs.syncthing.net/index.html.
