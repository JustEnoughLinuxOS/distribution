&nbsp;&nbsp;<img src="https://raw.githubusercontent.com/JustEnoughLinuxOS/distribution/dev/distributions/JELOS/logos/jelos-logo.png" width=192>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[![Latest Version](https://img.shields.io/github/release/JustEnoughLinuxOS/distribution.svg?color=5998FF&label=latest%20version&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/releases/latest) [![Activity](https://img.shields.io/github/commit-activity/m/JustEnoughLinuxOS/distribution?color=5998FF&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/commits) [![Pull Requests](https://img.shields.io/github/issues-pr-closed/JustEnoughLinuxOS/distribution?color=5998FF&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/pulls) [![Discord Server](https://img.shields.io/discord/948029830325235753?color=5998FF&label=chat&style=flat-square)](https://discord.gg/seTxckZjJy)
#

# Developing and Building JELOS

JELOS is a fairly unique distribution as it is *built to order* and only enough of the operating system and applications are built for the purpose of booting and executing emulators and ports.  Developers and others who would like to contribute to our project should read and agree to the [Contributor Covenant Code of Conduct](https://github.com/JustEnoughLinuxOS/distribution/blob/main/CODE_OF_CONDUCT.md) and [Contributing to JELOS](https://github.com/JustEnoughLinuxOS/distribution/blob/main/CONTRIBUTING.md) guides before submitting your first contribution.

## Preparing the Build Machine
Building JELOS requires a host with 200GB of free space for a single device, or 1TB of free space for a full world build.  

**Expect your first build to take on the order of ten hours.  You will need a stable internet connection, since hundreds of packages will be downloaded from their source.**  Download errors often produce build failures with misleading error messages.  If this happens to you, see the Troubleshooting section below.

After a clean build, all subsequent builds will go much faster (minutes) since 99% of the build work is cached.

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

### Virtual Machines
If you must use a virtual machine for your build platform, keep in mind that results vary.  There have been some anecdotes of success with VMware Workstation (Player and Pro) and failure with VirtualBox and WSL.  These reports are not definitive, but something to keep in mind if you must use a VM.

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
make docker-shell
CLEAN_PACKAGES="linux ppsspp-sa" make AMD64
exit
```
The first and last lines should be omitted if building outside of Docker.

## Troubleshooting
The very first build after a fresh checkout is the hardest.  Give yourself sufficient time to generate the first build and work through any failures before attempting to modify JELOS.
- Download errors produce misleading failure messages.  Beware of chasing red herrings.  A network failure is much more likely than a bug in the makefile, given how frequently it is tested by the CI system and other devs.
- Try cleaning the failed package (see above) and building again.
- If you suspect a download failure, manually delete the relevant package(s) from the `sources` and `build.JELOS-...` directories, to force a full package re-download and re-build.
- Exhaust all options before using `make clean` since this deletes the build cache and takes hours to regenerate.
- As a very last resort, delete the entire local repository and start over.

## Modifying JELOS
Before modifying JELOS, be sure you can successfully build the unmodified `main` or `dev` branch (see above).  Establish a baseline of success before introducing changes to the JELOS source.

### Building a Single Package
When modifying individual packages, it's useful to regularly verify the build-ability of your changes.  Rather than rebuild an entire device image, it is much faster to simply rebuild a single package using the following commands:
```
make docker-shell
export PROJECT=PC DEVICE=AMD64 ARCH=x86_64
./scripts/clean busybox
./scripts/build busybox
exit
```
The first and last lines should be omitted if building outside of Docker.  PROJECT is one of `Amlogic`, `PC`, or `Rockchip` (i.e. the subdirectories of the project directory).

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

### Building a Modified Image
If you already have a build for your device made using the above process, it's simple to shortcut the build process and create an image to test your changes quickly using the process below.
```
make docker-shell

# Update the package version for a new package, or apply your patch as above.
vim/emacs/vscode/notepad.exe

export OS_VERSION=$(date +%Y%m%d) BUILD_DATE=$(date)
export PROJECT=PC DEVICE=AMD64 ARCH=x86_64
./scripts/clean emulationstation
./scripts/build emulationstation
./scripts/install emulationstation
./scripts/image mkimage

exit
```
The first and last lines should be omitted if building outside of Docker.

### Pushing Modified Images to a Device
You can of course reflash the SD card with the modified image.

Alternatively, you may install the image through the JELOS update mechanism, which retains your ES and emulator settings.  If the device is networked and reachable from the build machine, this can be done as follows.
```
# Replace with your device values
HOST=192.168.0.123
DEVICE=RK3566
ARCH=aarch64

# Assume today is the same UTC day that the image was built
TIMESTAMP=$(date -u +%Y%m%d)

SSH_OPTS="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
scp ${SSH_OPTS} ~/distribution/release/JELOS-${DEVICE}.${ARCH}-${TIMESTAMP}.tar root@${HOST}:~/.update && \
    ssh ${SSH_OPTS} root@{HOST} reboot
```
