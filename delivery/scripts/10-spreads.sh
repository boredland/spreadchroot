#!/bin/bash
set -e
set -x

# Install spreads dependencies
apt-get -y --force-yes install \
python2.7-dev python-pip pkg-config \
libffi-dev libturbojpeg-dev libmagickwand-dev python-cffi \
liblua5.2-dev libusb-dev libgphoto2-dev python-yaml \
python-colorama python-yaml python-concurrent.futures \
python-blinker python-roman python-usb python-psutil \
python-flask python-requests python-wand python-netifaces \
python-dbus python-ipy python-selinux python-semanage \
python-sepolgen python-sepolicy python-setools python-enum34 \
python-backports.ssl-match-hostname
pip install tornado #deb package pyhton-tornado doesn't work
pip install hidapi-cffi gphoto2-cffi 
pip install jpegtran-cffi isbnlib zipstream
pip install lupa --install-option="--no-luajit"
pip install chdkptp.py

if [ -e $DELIVERY_DIR/spreads-sdist.tar.gz ]; then
    pip install $DELIVERY_DIR/spreads-sdist.tar.gz
else
pip install http://buildbot.diybookscanner.org/nightly/spreads-latest.tar.gz
fi

# Create spreads configuration directoy
mkdir -p /home/spreads/.config/spreads
mkdir -p /home/spreads/scans
cp $DELIVERY_DIR/files/config.yaml /home/spreads/.config/spreads
chown -R spreads /home/spreads/.config/spreads

# Install spreads init.d service
cp $DELIVERY_DIR/files/spreadserver /etc/init.d/
chmod +x /etc/init.d/spreadserver
