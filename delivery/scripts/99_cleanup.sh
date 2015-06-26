#!/usr/bin/env bash
set -x
set -e
apt-get -y remove --purge --auto-remove build-essential cmake automake git-core libtool \
libleptonica-dev git-core zlib1g-dev ruby-dev rubygems
apt-get -y autoremove
apt-get clean
