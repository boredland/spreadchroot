#!/usr/bin/env bash
set -e
set -x
##starting from a clean 14.04 system
sudo apt-get update
sudo apt-get upgrade	
##now install all dependcies
sudo apt-get install python2.7 python2.7-dev python-virtualenv \
python-tk idle python-pmw python-imaging \
python-pip libpython2.7-dev libusb-dev \
libjpeg-dev libtiff5-dev libqt4-core ruby-rmagick \
libmagickwand-dev lua5.2 liblua5.2-dev \
ruby-hpricot git imagemagick build-essential \
libqt4-dev libjpeg8-dev libjpeg-turbo8-dev libjpeg-dev git \
ghostscript ruby1.9.1 ruby1.9.1-dev rubygems1.9.1 \
irb1.9.1 ri1.9.1 rdoc1.9.1 libopenssl-ruby1.9.1 libssl-dev \
zlib1g-dev cmake zlib1g-dev libpng12-dev libtiff5-dev libhidapi-dev \
libboost1.55-all-dev libxrender-dev libturbojpeg python-pyside \
automake libtool libpango1.0-dev python-psutil libffi-dev -y
