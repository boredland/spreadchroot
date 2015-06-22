#!/bin/bash
set -e
set -x

# Install spreads dependencies
    apt-get -y --force-yes install --no-install-recommends \
        python python-colorama python-yaml python-concurrent.futures \
        python-blinker python-roman python-usb python-psutil libjpeg-dev \
        python-flask python-requests python-wand python-netifaces \
        python-dbus liblua5.2-dev libusb-dev python-cffi libturbojpeg-dev \
        libgphoto2-dev 
    apt-get -y install python-pip build-essential python2.7-dev pkg-config
    pip install tornado
    pip install jpegtran-cffi
    pip install lupa --install-option="--no-luajit"
    pip install chdkptp.py
    pip install gphoto2-cffi

# Create spreads configuration directoy
mkdir -p /home/spreads/.config/spreads
cp $DELIVERY_DIR/files/config.yaml /home/spreads/.config/spreads
chown -R spreads /home/spreads/.config/spreads

# Install spreads systemd service
cp $DELIVERY_DIR/files/spreads.service /etc/systemd/system/
systemctl enable spreads
