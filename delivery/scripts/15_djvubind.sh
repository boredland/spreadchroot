#!/usr/bin/env bash
set -e
set -x
apt-get -y --force-yes install djvulibre-bin python3 minidjvu
git clone https://github.com/strider1551/djvubind
cd djvubind
./setup.py install
cd ..
rm -r djvubind
