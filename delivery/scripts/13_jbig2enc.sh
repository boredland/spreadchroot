#!/bin/bash
set -x
set -e

git clone https://github.com/agl/jbig2enc
cd jbig2enc
./autogen.sh
./configure
make -j$CORES
make install
cd ..
rm -r jbig2enc
#dpkg -i $DELIVERY_DIR/files/jbig2enc_*_armhf.deb
