#!/usr/bin/env bash
set -x
set -e
apt-get -y remove --purge --auto-remove build-essential cmake automake git*
apt-get -y --force-yes autoremove
apt-get clean
