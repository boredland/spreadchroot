#!/usr/bin/env bash
set -x
## Install spreads
sudo pip install jpegtran-cffi Flask requests zipstream tornado Wand
sudo pip install http://buildbot.diybookscanner.org/nightly/spreads-latest.tar.gz#egg=spreads[web]
