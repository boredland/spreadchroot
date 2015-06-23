#!/bin/bash
set -e
set -x

# Install spreads dependencies
    apt-get -y --force-yes install build-essential python3 python3-dev python3-pip pkg-config
    apt-get -y --force-yes install --no-install-recommends python3-colorama \
	python3-yaml python3-blinker python3-roman python3-psutil libjpeg-dev \
        python3-flask python3-requests python3-wand python3-netifaces \
        python3-dbus liblua5.2-dev libusb-dev python3-cffi libturbojpeg-dev \
        libgphoto2-dev

# i think concurrent.futures is in python3 stdlib? perhaps. fuck it.
    pip3 install lupa --install-option="--no-luajit"
    pip3 install tornado jpegtran-cffi chdkptp.py gphoto2-cffi zipstream
    pip3 install --pre pyusb
    pip3 install http://buildbot.diybookscanner.org/nightly/spreads-latest.tar.gz
# Create spreads configuration directoy
mkdir -p /home/spreads/.config/spreads
cp $DELIVERY_DIR/files/config.yaml /home/spreads/.config/spreads
chown -R spreads /home/spreads/.config/spreads

# Install spreads systemd service
cp $DELIVERY_DIR/files/spreads.service /etc/systemd/system/
systemctl enable spreads
