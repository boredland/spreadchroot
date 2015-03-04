#!/usr/bin/env bash
set -x
## Install spreads
sudo pip install jpegtran-cffi Flask requests zipstream tornado Wand
wget http://buildbot.diybookscanner.org/nightly/spreads-latest.tar.gz
sudo pip install spreads-latest.tar.gz
