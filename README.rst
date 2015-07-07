Spreadchroot aims to create a chroot-environment - mainly on android-based devices - to run a full spreads suite. It may be useful for other usecases as a spreads processor or a spreads standalone device.

You'll find an setup guide in the wiki (https://github.com/boredland/spreadchroot/wiki).

You'll find ready images at:

* https://mega.nz/#F!eV9lURzB!yriu6sXFmGuZXWsOIekM0w

The images are 2.5Gb large, leaving you a workspace of ~1Gb. If you want to resize that, refer to this tutorial :
http://softwarebakery.com/shrinking-images-on-linux
or change the imagesize parameter in the build.sh. Keep in mind, that fat32 only supports files up to 4Gb. You are better of using a sd-card For spreadchroot. I'll explain that in a future wiki-update.

Build Requirements
==================
* `git`
* `binfmt_misc` kernel module loaded
* `qemu-arm-static`
* `deboostrap`
* `kpartx`
* `mkfs.vfat`
* `mkfs.ext4`
* `dmsetup`

Oneliner for Ubuntu 14.04:
::
    sudo apt-get install debian-archive-keyring git-core binfmt-support qemu qemu-user-static debootstrap kpartx dmsetup dosfstools apt-cacher-ng


Building
========
To generate an image, run the `build.sh` script as root:

::

    $ sudo ./build.sh
    
There are some environment variables that you can set to customize the build:

`IMAGESIZE`
    Target size for the image in MB (default: `4000`)
`DEB_RELEASE`
    Target Debian release, can be `stable`, `testing` or `unstable` (default: `jessie`)
`DEFAULT_DEB_MIRROR`
    Repository URL to grab packages from (default: `http://ftp.de.debian.org/debian/`)
`USE_LOCAL_MIRROR`
    For use with `apt-cacher-ng`, can be `true` or `false` (default: `true`)
`SSH_KEY`
    Public key to enable SSH Login for (default: `~/.ssh/id_rsa.pub`)
`DEBUG`
    Drop into a chroot shell after the image has finished building (default: `false`)

The image will generate a debian image with up-to-date packages and spreads
pre-installed and pre-configured in full-mode(for use with Canon A2200 cameras running CHDK).

Login accounts:
    * root:raspberry
    * spreads:changeme
    
The `spreads` user is allowed to run all commands with superuser privileges through `sudo`.
