#!/usr/bin/env bash
set -e
set -x
command -v jbig2 >/dev/null 2>&1 || {
git clone https://github.com/agl/jbig2enc
cd jbig2enc
./autogen.sh
./configure
make -j$2
sudo make install
cd ..
}
