#!/bin/bash
set -e
set -x

cp $DELIVERY_DIR/files/spreadchroot.service /etc/systemd/system/
systemctl enable spreadchroot
