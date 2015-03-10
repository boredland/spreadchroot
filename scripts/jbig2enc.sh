#!/bin/bash
set -x
if [[ $2 == 1 ]]; then exit 0;fi
command -v jbig2 >/dev/null 2>&1 || {
git clone https://github.com/agl/jbig2enc
cd jbig2enc
./autogen.sh
./configure
make -j$1
sudo make install
cd ..
}
