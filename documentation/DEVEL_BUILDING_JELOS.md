&nbsp;&nbsp;<img src="https://raw.githubusercontent.com/JustEnoughLinuxOS/distribution/dev/distributions/JELOS/logos/jelos-logo.png" width=192>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[![Latest Version](https://img.shields.io/github/release/JustEnoughLinuxOS/distribution.svg?color=5998FF&label=latest%20version&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/releases/latest) [![Activity](https://img.shields.io/github/commit-activity/m/JustEnoughLinuxOS/distribution?color=5998FF&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/commits) [![Pull Requests](https://img.shields.io/github/issues-pr-closed/JustEnoughLinuxOS/distribution?color=5998FF&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/pulls) [![Discord Server](https://img.shields.io/discord/948029830325235753?color=5998FF&label=chat&style=flat-square)](https://discord.gg/seTxckZjJy)
#

# Developing and Building JELOS

JELOS is a fairly unique distribution as it is *built to order* and only enough of the operating system and applications are built for the purpose of booting and executing emulators and ports.  Developers and others who would like to contribute to our project should read and agree to the [Contributor Covenant Code of Conduct](https://github.com/JustEnoughLinuxOS/distribution/blob/main/CODE_OF_CONDUCT.md) and [Contributing to JELOS](https://github.com/JustEnoughLinuxOS/distribution/blob/main/CONTRIBUTING.md) guides before submitting your first contribution.

## Preparing the Build Machine
Building JELOS requires a host with 200GB of free space for a single device, or 1TB of free space for a full world build.  

### Docker Builds
**Docker is the easiest and most reliable way to build JELOS.**  You need no previous experience with Docker; you merely need to install it on your build machine.  Newcomers to the project are strongly recommended to use this approach.

We recommend using Ubuntu 22.04 for the host machine, as this is well-tested and known to work.  Other distributions and operating systems might also work for Docker builds, but are untested and unsupported.

Install Docker using the following commands:
```
sudo apt update
sudo apt install ca-certificates curl gnupg

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

docker run hello-world
```
> Docker installation reference (source): [Install using the apt repository](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository) and [Linux post-installation steps](https://docs.docker.com/engine/install/linux-postinstall/).

The final command should produce a message indicating that Docker is properly installed.  If you encounter any errors, see the reference links above.

### Manual Builds
Manual builds (outside of Docker) are only recommended for developers with specific needs that cannot be met by the Docker approach.  The host configuration should match the Docker container as closely as possible, running Ubuntu 22.04 with all packages listed in the [Dockerfile](../Dockerfile).

## JELOS Source Files
After preparing the build machine, clone the project git repository onto it.

```
cd ~
git clone https://github.com/JustEnoughLinuxOS/distribution.git
```

### Selecting the Desired Branch
Once you have cloned the repo, decide whether you want to build the main branch which is more stable, or the development branch which is unstable but hosts our newest features.

|Branch|Purpose|
|----|----|
|main|Stable JELOS sources|
|dev|Unstable JELOS sources|

To check out our development branch, cd into the project directory and checkout `dev`.

```
cd distribution
git checkout dev
```

### Filesystem Structure
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

Build roots for each device and that device's architecture(s).  For ARM devices JELOS builds and uses a 32bit root for several of the cores used in the 64bit distribution.

**config**

Contains functions utilized during the build process including architecture specific build flags, optimizations, and functions used throughout the build workflow.

**distributions**

Distributions contains distribution-specific build flags and parameters and splash screens.

**Dockerfile**

Used to build the Ubuntu container used to build JELOS.  The container is hosted at [https://hub.docker.com/u/justenoughlinuxos](https://hub.docker.com/u/justenoughlinuxos).

**licenses**

All of the licenses used throughout the distribution packages are hosted here.  If you're adding a package that contains a license, make sure it is available in this directory before submitting the PR.

**Makefile**

Used to build one or more JELOS images, or to build and deploy the Ubuntu container.

**packages**

All of the packages used to develop and build JELOS are hosted within the packages directory.  The package structure documentation is available in [DEVEL_CREATING_PACKAGES.md](DEVEL_CREATING_PACKAGES.md).

**post-update**

Anything that is necessary to be run on a device after an upgrade should be added here.  Be sure to apply a guard to test that the change needs to be executed before execution.

**projects**

Hardware-specific parameters are stored in the projects folder.  Anything that should not be included on every device during a world build should be isolated to the specific project or device here.

**release**

The output directory for all of the build images.

**scripts**

This directory contains all of the scripts used to fetch, extract, build, and release the distribution.  Review Makefile for more details.

**sources**

As the distribution is being built, package source files are fetched and hosted in this directory.  They will persist after a `make clean`.

**tools**

The tools directory contains utility scripts that can be used during the development process, including a simple tool to burn an image to a usb drive or sdcard.

## Building JELOS

### Building Device Images
Building JELOS is easy.  From the root of your local repository, issue one of the `make` commands listed below, depending on the desired device and whether you are using Docker.

| Devices | Dependency | Docker Command | Manual Command |
| ---- | ---- | ---- | ---- |
|AMD64||```make docker-AMD64```|```make AMD64```|
|RK3588||```make docker-RK3588```|```make RK3588```|
|RK3326||```make docker-RK3326```|```make RK3326```|
|RK3566||```make docker-RK3566```|```make RK3566```|
|RK3566-X55|RK3566|```make docker-RK3566-X55```|```make RK3566-X55```|
|S922X||```make docker-S922X```|```make S922X```|
|ALL DEVICES||```make docker-world```|```make world```|

> Devices that list a dependency require you to build the dependency first, since that build will be used as the root of the device you are building.

For example, the following command uses Docker to build the AMD64 image.  

```
make docker-AMD64
```

### Rightsized Builds
JELOS supports various build variables which alter the behavior of the distribution for specific purposes including debugging, or hosting containers.  The options are defined below and are passed on the make command line.  Ex. `BASE_ONLY=true make docker-RK3566`.

|Build Option|Default|Function|
|----|----|----|
|EMULATION_DEVICE|yes|Builds EmulationStation and all emulators if `yes`. Builds EmulationStation and NO emulators if `no`.|
|ENABLE_32BIT|yes|Builds a 32bit root and includes it in the image.  Needed for 32bit cores and applications.|
|BASE_ONLY|false<sup>1</sup>|Builds only the bare minimum packages.  Includes Weston on supported devices.  Does not build EmulationStation.|
|CONTAINER_SUPPORT|no|Builds support for running containers on JELOS.|

> Note: <sup>1</sup> this property will change to yes/no for consistency in a future release.

### Special env Variables
For development builds, you can use the following env variables to customize the image or change build time functionality. To make them globally available to the builds, add them to ${HOME}/.JELOS/options.

|Variable|Function|
|----|----|
|LOCAL_SSH_KEYS_FILE|Enables using ssh public keys for access without the root password.|
|LOCAL_WIFI_SSID|The SSID of the network the device should connect to automatically.|
|LOCAL_WIFI_KEY|The WIFI authentication key for the connection."|
|SCREENSCRAPER_DEV_LOGIN|Login information for screenscraper.fr.|
|GAMESDB_APIKEY|Login information for thegamesdb.net.|
|CHEEVOS_DEV_LOGIN|Login information for retroachievements.org.|
|CLEAN_PACKAGES|Allows specifying packages to clean during a build.|

#### SSH Keys
```
export LOCAL_SSH_KEYS_FILE=~/.ssh/jelos/authorized_keys
```
#### WiFi SSID and password
```
export LOCAL_WIFI_SSID=MYWIFI
export LOCAL_WIFI_KEY=secret
```

#### Screenscraper, GamesDB, and RetroAchievements

To enable Screenscraper, GamesDB, and RetroAchievements, register at each site and apply the api keys in ${HOME}/.JELOS/options. Unsetting one of the variables will disable it in EmulationStation. This configuration is picked up by EmulationStation during the build.

```
# Apply for a Screenscraper API Key here: https://www.screenscraper.fr/forumsujets.php?frub=12&numpage=0
export SCREENSCRAPER_DEV_LOGIN="devid=DEVID&devpassword=DEVPASSWORD"
# Apply for a GamesDB API Key here: https://forums.thegamesdb.net/viewforum.php?f=10
export GAMESDB_APIKEY="APIKEY"
# Find your Cheevos Web API key here: https://retroachievements.org/controlpanel.php
export CHEEVOS_DEV_LOGIN="z=RETROACHIEVEMENTSUSERNAME&y=APIKEYID"
```

#### Cleaning Additional Packages
```
CLEAN_PACKAGES="linux ppsspp-sa" make AMD64
```

## Modifying JELOS

### Building a Single Package
It is also possible to build individual packages.
```
DEVICE=AMD64 ARCH=x86_64 ./scripts/clean busybox
DEVICE=AMD64 ARCH=x86_64 ./scripts/build busybox
```
> Note: An EmulationStation package standalone build requires additional steps because its source code is located in a separate repository.  See instructions [here](https://github.com/JustEnoughLinuxOS/distribution/blob/main/packages/ui/emulationstation/package.mk).

### Creating a Patch for a Package
It is common to have imported package source code modifed to fit the use case. It's recommended to use a special shell script to build it in case you need to iterate over it. See below.

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

### Creating a Patch for a Package Using git
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

After the patch is generated, rebuild an individual package by following the section above. The build system will automatically pick up patch files from the `patches` directory. For testing, one can either copy the built binary to the console or burn the whole image on SD card.

### Building an Image with Your Patch
If you already have a build for your device made using the above process, it's simple to shortcut the build process and create an image to test your changes quickly using the process below.
```
# Update the package version for a new package, or apply your patch as above.
vim/emacs/vscode/notepad.exe
# Export the variables needed to complete your build.  We'll assume you are building AMD64; update the device to match your configuration.
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
