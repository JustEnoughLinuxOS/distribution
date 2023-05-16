# Developing and Building JELOS

JELOS is a fairly unique distribution as it is *built to order* and only enough of the operating system and applications are built for the purpose of booting and executing emulators and ports.  Developers and others who would like to contribute to our project should read and agree to the [Contributor Covenant Code of Conduct](https://github.com/JustEnoughLinuxOS/distribution/blob/main/CODE_OF_CONDUCT.md) and [Contributing to JELOS](https://github.com/JustEnoughLinuxOS/distribution/blob/main/CONTRIBUTING.md) guides before submitting your first contribution.


## Filesystem Structure
We have a simple filesystem structure adopted from parent distributions CoreELEC, LibreELEC, etc.

```
.
├── build.JELOS-DEVICE.ARCHITECTURE
├── config
├── distributions
├── Dockerfile
├── licenses
├── Makefile
├── packages
├── post-update
├── projects
├── release
├── scripts
├── sources
└── tools
```

**build.JELOS-DEVICE.ARCHITECTURE**

Build roots for each device and that devices architecture(s).  For ARM devices JELOS builds and uses a 32bit root for several of the cores used in the 64bit distribution.

**config**

Contains functions utilized during the build process including architecture specific build flags, optimizations, and functions used throughout the build workflow.

**distributions**

Distributions contains distribution specific build flags and parameters and splash screens.

**Dockerfile**

Used to build the Ubuntu container used to build JELOS.  The container is hosted at [https://hub.docker.com/u/justenoughlinuxos](https://hub.docker.com/u/justenoughlinuxos)

**licenses**

All of the licenses used throughout the distribution packages are hosted here.  If you're adding a package that contains a license, make sure it is available in this directory before submitting the PR.

**Makefile**

Used to build one or more JELOS images, or to build and deploy the Ubuntu container.

**packages**

All of the package set that is used to develop and build JELOS are hosted within the packages directory.  The package structure documentation is available in [PACKAGE.md](PACKAGE.md)

**post-update**

Anything that is necessary to be run on a device after an upgrade should be added here.  Be sure to apply a guard to test that the change needs to be executed before execution.

**projects**

Hardware specific parameters are stored in the projects folder, anything that should not be included on every device during a world build should be isolated to the specific project or device here.

**release**

The output directory for all of the build images.

**scripts**

This directory contains all of the scripts used to fetch, extract, build, and release the distribution.  Review Makefile for more details.

**sources**

As the distribution is being built, package source are fetched and hosted in this directory.  They will persist after a `make clean`.

**tools**

The tools directory contains utility scripts that can be used during the development process, including a simple tool to burn an image to a usb drive or sdcard.

## Building JELOS
Building JELOS requires an Ubuntu 22.04 host with 200GB of free space for a single device, or 1TB of free space for a full world build.  Other Linux distributions may be used when building using Docker, however this is untested and unsupported.

### Cloning the JELOS Sources
To build JELOS, start by cloning the project git repository.

```
cd ~
git clone https://github.com/JustEnoughLinuxOS/distribution.git
```

### Selecting the Desired Branch
Once you have cloned the repo, you will want to determine if you want to build the main branch which is more stable, or the development branch which is unstable but hosts our newest features.

|Branch|Purpose|
|----|----|
|main|Stable JELOS sources|
|dev|Unstable JELOS sources|

To check out our development branch, cd into the project directory and checkout `dev`.

```
cd distribution
git checkout dev
```

### Building with Docker
Building JELOS is easy, the fastest and most recommended method is to instruct the build to use Docker, this is only known to work on a Linux system.  To build JELOS with Docker use the table below.

| Devices | Dependency | Docker Command |
| ---- | ---- | ---- |
|AMD64||```make docker-AMD64```|
|RK3588||```make docker-RK3588```|
|RK3326||```make docker-RK3326```|
|RK3566||```make docker-RK3566```|
|RK3566-X55||```make docker-RK3566-X55```|
|S922X||```make docker-S922X```|
|ALL DEVICES||```make docker-world```|

> Devices that list a dependency require the dependency to be built first as that build will be used as the root of the device you are building.  This will be done automatically by the build tooling when you start a build for your device.

### Building Manually
To build JELOS manually, you will need several prerequisite packages installed.

```
sudo apt install gcc make git unzip wget \
                xz-utils libsdl2-dev libsdl2-mixer-dev libfreeimage-dev libfreetype6-dev libcurl4-openssl-dev \
                rapidjson-dev libasound2-dev libgl1-mesa-dev build-essential libboost-all-dev cmake fonts-droid-fallback \
                libvlc-dev libvlccore-dev vlc-bin texinfo premake4 golang libssl-dev curl patchelf \
                xmlstarlet patchutils gawk gperf xfonts-utils default-jre python-is-python3 xsltproc libjson-perl \
                lzop libncurses5-dev device-tree-compiler u-boot-tools rsync p7zip libparse-yapp-perl \
                zip binutils-aarch64-linux-gnu dos2unix p7zip-full libvpx-dev bsdmainutils bc meson p7zip-full \
                qemu-user-binfmt zstd parted imagemagick docker.io
```

Next, build the version of JELOS for your device.  See the table above for dependencies. 

```
make AMD64
```

### Building a single package
It is also possible to build individual packages.
```
DEVICE=AMD64 ARCH=x86_64 ./scripts/clean busybox
DEVICE=AMD64 ARCH=x86_64 ./scripts/build busybox
```
> Note: An EmulationStation package standalone build requires additional steps because its source code located in a separate repository, see instructions inside, [link](https://github.com/JustEnoughLinuxOS/distribution/blob/main/packages/ui/emulationstation/package.mk).

### Rightsized builds
JELOS supports various build variables which alter the behavior of the distribution for specific purposes including debugging, or hosting containers.  The options are defined below and are passed on the make command line.  Ex. `BASE_ONLY=true make docker-RK3566`.

|Build Option|Setting|Function|
|----|----|----|
|EMULATION_DEVICE|yes|Builds EmulationStation and all emulators, builds EmulationStation and NO emulators if false.|
|ENABLE_32BIT|yes|Builds a 32bit root and includes it in the image.  Needed for 32bit cores and applications.|
|BASE_ONLY|false<sup>1</sup>|Builds only the bare minimum packages, includes Weston on supported devices.  Does not build EmulationStation.|
|CONTAINER_SUPPORT|no|Builds support for running containers on JELOS|

> Note: <sup>1</sup> this property will change to yes/no for consistency in a future release.

### Special env variables
For development build, you can use the following env variables to customize the image. Some of them can be included in your `.bashrc` startup shell script.

**SSH keys**
```
export LOCAL_SSH_KEYS_FILE=~/.ssh/jelos/authorized_keys
```
**WiFi SSID and password**
```
export LOCAL_WIFI_SSID=MYWIFI
export LOCAL_WIFI_KEY=secret
```

**Screenscraper, GamesDB, and RetroAchievements**

To enable Screenscraper, GamesDB, and RetroAchievements, register at each site and apply the api keys in ~/developer_settings.conf or add them as environment variables. Unsetting one of the variables will disable it in EmulationStation. This configuration is picked up by EmulationStation during the build.

```
# Apply for a Screenscraper API Key here: https://www.screenscraper.fr/forumsujets.php?frub=12&numpage=0
export SCREENSCRAPER_DEV_LOGIN="devid=DEVID&devpassword=DEVPASSWORD"
# Apply for a GamesDB API Key here: https://forums.thegamesdb.net/viewforum.php?f=10
export GAMESDB_APIKEY="APIKEY"
# Find your Cheevos Web API key here: https://retroachievements.org/controlpanel.php
export CHEEVOS_DEV_LOGIN="z=RETROACHIEVEMENTSUSERNAME&y=APIKEYID"
```

### Creating a patch for a package
It is common to have imported package source code modifed to fit the use case. It's recommended to use a special shell script to built it in case you need to iterate over it. See below.

```
cd sources/wireguard-linux-compat
tar -xvJf wireguard-linux-compat-v1.0.20211208.tar.xz
mv wireguard-linux-compat-v1.0.20211208 wireguard-linux-compat
cp -rf wireguard-linux-compat wireguard-linux-compat.orig

# Make your changes to wireguard-linux-compat
mkdir -p ../../packages/network/wireguard-linux-compat/patches/AMD64
# run from the sources dir
diff -rupN wireguard-linux-compat wireguard-linux-compat.orig >../../packages/network/wireguard-linux-compat/patches/AMD64/mychanges.patch
```

### Creating a patch for a package using git
If you are working with a git repository, building a patch for the distribution is simple.  Rather than using `diff`, use `git diff`.
```
cd sources/emulationstation/emulationstation-098226b/
# Make your changes to EmulationStation
vim/emacs/vscode/notepad.exe
# Make the patch directory
mkdir -p ../../packages/ui/emulationstation/patches
# Run from the sources dir
git diff >../../packages/ui/emulationstation/patches/005-mypatch.patch
```

After patch is generated, one can rebuild an individual package, see section above. The build system will automatically pick up patch files from `patches` directory. For testing, one can either copy the built binary to the console or burn the whole image on SD card.

### Building an image with your patch
If you already have a build for your device made using the above process, it's simple to shortcut the build process and create an image to test your changes quickly using the process below.
```
# Update the package version for a new package, or apply your patch as above.
vim/emacs/vscode/notepad.exe
# Export the variables needed to complete your build, we'll assume you are building AMD64, update the device to match your configuration.
export OS_VERSION=$(date +%Y%m%d) BUILD_DATE=$(date)
export PROJECT=PC ARCH=x86_64 DEVICE=AMD64
# Clean the package you are building.
./scripts/clean emulationstation
# Build the package.
./scripts/build emulationstation
# Install the package into the build root.
./scripts/install emulationstation
# Generate an image with your new package.
./scripts/image mkimage
```
