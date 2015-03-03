#!/usr/bin/env bash
set -e
set -x
if [[ $1 == 1 ]]; then exit 0;fi
command -v convertfilestopdf >/dev/null 2>&1 || {
wget http://www.leptonica.com/source/leptonica-1.71.tar.gz
tar xvf leptonica-1.71.tar.gz
cd leptonica-1.71/
./autobuild
./configure
make -j$2
sudo make install
cd ..
}
