#!/usr/bin/env bash
set -e
##starting from a clean 14.04 system
sudo apt-get update
sudo apt-get upgrade	
## general depencies
sudo apt-get install python2.7-dev python-pip build-essential \
pkg-config libffi-dev libmagickwand-dev python-cffi libturbojpeg  -y
