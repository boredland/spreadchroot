#!/usr/bin/env bash
set -x
if [[ $1 == 2 ]]; then exit 0;fi
##create and open a new file - not necessary I think
if grep -q /usr/local/lib/chdkptp/ "/etc/ld.so.conf.d/spreads.conf"
then
sudo sh -c "echo '/usr/local/lib/chdkptp/' >> /etc/ld.so.conf.d/spreads.conf"
fi
