#! /bin/bash
set -x
set -e

# User spreads needs to mount usb disks
apt-get -y install dbus udisks
cp $DELIVERY_DIR/files/55-udisks.pkla /etc/polkit-1/localauthority/50-local.d/
