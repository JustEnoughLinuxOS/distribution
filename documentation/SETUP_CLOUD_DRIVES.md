&nbsp;&nbsp;<img src="https://raw.githubusercontent.com/JustEnoughLinuxOS/distribution/dev/distributions/JELOS/logos/jelos-logo.png" width=192>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[![Latest Version](https://img.shields.io/github/release/JustEnoughLinuxOS/distribution.svg?color=5998FF&label=latest%20version&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/releases/latest) [![Activity](https://img.shields.io/github/commit-activity/m/JustEnoughLinuxOS/distribution?color=5998FF&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/commits) [![Pull Requests](https://img.shields.io/github/issues-pr-closed/JustEnoughLinuxOS/distribution?color=5998FF&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/pulls) [![Discord Server](https://img.shields.io/discord/948029830325235753?color=5998FF&label=chat&style=flat-square)](https://discord.gg/seTxckZjJy)
#

# Configuring Rclone in JELOS
JELOS now supports mounting cloud volumes, and backing up and restoring save games and save states to your cloud provider.  Using Rclone is easy, however configuration must be performed manually before it will function correctly.

rclone.cfg is stored in `/storage/.config/rclone/rclone.conf` and can be copied from another device but only after the destination device has booted into Jelos (so copy to secondary sd, boot device, launch 351files, copy from there to proper path above)

## Setup Rclone
### Credentialed Access
To set up rclone, open an ssh connection to your handheld using PowerShell ssh, putty, or ssh on Linux and Mac.
* Username: root (all lower case!)
* Password: (To get the root password, press Start, then Select System Settings.)
* Connection: (Your device, example RG552 or RG351MP.)

### Example using PowerShell ssh, Linux, or macOS:
```ssh root@RG552```

### Setting up Rclone
Now that you're connected you will need to configure Rclone.  This process is menu driven, but also requires steps on your PC.  To complete configuration of Rclone, run `rclone config` in your ssh session and then follow the provider documentation and headless configuration steps to configure it for your cloud provider of choice.

* [Rclone Provider Documentation](https://rclone.org/#providers)
* [Rclone Headless Configuration](https://rclone.org/remote_setup/)

[See detailed setup example below](https://github.com/JustEnoughLinuxOS/distribution/wiki/Using-Cloud-Drives/#setting-up-rclone-detailed-example) 

### Using Rclone
In JELOS you are able to mount your cloud drive like any other storage device, as long as you are network connected.  To mount your cloud drive, press Start, select Network Settings, and then select the Mount Cloud Drive option.  This drive is available on /storage/cloud by default, and is accessible from ssh and from 351Files.  To mount the cloud drive over ssh use ```rclonectl mount``` to mount the drive and ```rclonectl unmount``` to unmount it.

> Note: Mounting the cloud drive is not persistent, you will need to select it before use.

### Using Cloud Backup and Restore
In the tools menu you will find two options, `Cloud Backup`, and `Cloud Restore`.  These tools will back up or restore your save games and save states by connecting your cloud drive and copying them.  These tools are configurable by editing /storage/.config/rsync.conf and /storage/.config/rsync-rules.conf.

> Note: The cloud backup and restore tools are destructive, but they do not delete data by default.  Deletes are left to the user to manage.

#### rsync.conf
The rsync.conf configuration file contains parameters used by the cloud tools that provide the path for your cloud drive to be mounted, the path to sync the data from, the destination for the sync and rsync options for cloud backup and restore.  The configuration is user editable, and the defaults are as follows:
```
### This is the path where your cloud volume is mounted.
MOUNTPATH="/storage/cloud"

### This is the path to your game folder on your cloud drive.
SYNCPATH="GAMES"

### This is the path we are backup up from.
BACKUPPATH="/storage/roms"

### This allows changes to the rsync options for cloud_backup (pending stable release)
RSYNCOPTSBACKUP="-raiv --prune-empty-dirs"

### This allows changes to the rsync options for cloud_restore (pending stable release)
RSYNCOPTSRESTORE="-raiv"
```

#### rsync-rules.conf
The rsync-rules.conf configuration file contains the pattern used by rsync to know which files to backup and restore.  This file is user editable.  The default settings are as follows:
```
# This is a required rule for subdirectory matching.
+ */

### Do not include BIOS.
- bios/**

### Retroarch saves
+ *.sav
+ *.srm
+ *.auto
+ *.state*

### This is a required rule to exclude all other file types.
- *
```

To create custom match rules, use - to exclude and + to include.  Use caution as a mismatched rule can copy every single file from the source path or no files at all.

## Setting Up Rclone detailed example
This example configures rclone to use Dropbox

Rclone provide detailed examples for connecting to all supported cloud servers, including [Rclone Dropbox example](https://rclone.org/dropbox/)

### Configure cloud backup connection on JELOS device using ssh
From the terminal command line type
```
rclone version
```

and press `enter`

Note the version number, which is required for a later step

![Rclone version installed in JELOS](https://github.com/JustEnoughLinuxOS/distribution/blob/gh-pages/images/ssh%20rclone%20version.png "Check version of rclone")

Now type
```
rclone config
```

and press `enter`

type `n` to create a new remote site

type in a name for the site (use a name without spaces), then press `enter`

> rclone suggest using `remote`, but in this example the remote site is called `rg503`

> don’t include spaces in the site’s name. Rclone does allow names that include spaces, but rsync will fail if a site name with spaces is used in the cloud backup script.

![Type: rclone config](https://github.com/JustEnoughLinuxOS/distribution/blob/gh-pages/images/ssh%20rclone%20config.png "rclone config")

Choose from the list of cloud providers that is displayed. For Dropbox, type `12` and `enter` in this example

![Select cloud provider](https://github.com/JustEnoughLinuxOS/distribution/blob/gh-pages/images/ssh%20rclone%20config%20select%20dropbox.png "type 12 for Dropbox")

*The next options displayed are slightly different from the Dropbox example on rclone website*

For client_id and client_secret press `enter` and `enter` to skip, or read [Rclone Dropbox example](https://rclone.org/dropbox/) for details about setting up your own App ID (rclone App ID is shared with all rclone users by default)

Type `n` to skip editing the advanced config

![Skip Client ID, secret and advanced config](https://github.com/JustEnoughLinuxOS/distribution/blob/gh-pages/images/ssh%20rclone%20config%20client%20id.png "type enter to skip, then n for no")

For auto config, select `n` for remote or headless machine (i.e. JELOS device that doesn't have a web browser)

![No auto-config for remote or headless machine](https://github.com/JustEnoughLinuxOS/distribution/blob/gh-pages/images/ssh%20rclone%20config%20remote%20machine.png "type n for no")

Instructions are provided explaining how to authorize the connection from the remote device to the cloud service

![Device with web-browser is required for authorization](https://github.com/JustEnoughLinuxOS/distribution/blob/gh-pages/images/ssh%20rclone%20config%20authorize%20and%20paste%20token.png "Use pc to authorize connection")

### Install and run rclone on machine with a web-browser to authorize connection to cloud service

Download rclone on a device with a web-browser so rclone can use a web-page to authorize the connection by allowing you to login with your authorization credentials for the cloud service

[Rclone download server](https://downloads.rclone.org/ "Download same version of rclone for authorisation")

> Download the same version of rclone as is installed on JELOS device, as noted above.

Use terminal window (e.g. `CMD` on Windows) to browse to rclone executable and run 

```
rclone authorize dropbox
```

and press `enter`

![Authorize dropbox for rclone](https://github.com/JustEnoughLinuxOS/distribution/blob/gh-pages/images/rclone%20authorise%20dropbox.png "Authorize rclone from terminal command prompt")

Rclone will launch a web page to enable login to the cloud service and authorization of the connection

![Authorize dropbox for rclone](https://github.com/JustEnoughLinuxOS/distribution/blob/gh-pages/images/rclone%20authorise%20from%20pc.png "Confirm authorization of rclone connection")

After successful authorization, the terminal window will display the authorization token that needs to be pasted into JELOS ssh

![Copy authorization token](https://github.com/JustEnoughLinuxOS/distribution/blob/gh-pages/images/rclone%20authorise%20login%20then%20paste%20into%20remote%20ssh.png "Copy token to paste into JELOS ssh")

Copy the entire token

### Update JELOS with authorization token

Paste authorization token into JELOS command prompt, then type `y` to confirm that the remote connection is correct

![Paste authorization token into ssh](https://github.com/JustEnoughLinuxOS/distribution/blob/gh-pages/images/ssh%20rclone%20config%20authorize%20and%20paste%20token.png "Paste token at config_token prompt")

The connection is now configured and can be tested (`q` to quit rclone config)

Type 
```
rclone lsd rg503:
```

where `rg503` is the name of the remote connection (rclone example names the remote connection as `remote`)

> **don't forget to add `:` to the name of remote connection**

The names of the top-level folders within Dropbox cloud service will be displayed

![Dropbox folder names are displayed](https://github.com/JustEnoughLinuxOS/distribution/blob/gh-pages/images/ssh%20rclone%20list%20top-level%20directories%20on%20dropbox.png "Top-level folder names in Dropbox cloud service")

Now that the connection is set up and authorized [Using Rclone](https://github.com/JustEnoughLinuxOS/distribution/wiki/Using-Cloud-Drives#using-rclone) and [Using Cloud Backup and Restore](https://github.com/JustEnoughLinuxOS/distribution/wiki/Using-Cloud-Drives#using-cloud-backup-and-restore) explain how to configure and use the connection for backup
