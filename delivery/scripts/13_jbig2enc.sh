#!/bin/bash
set -x
set -e

git clone https://github.com/agl/jbig2enc
cd jbig2enc
./autogen.sh
./configure
make -j$1
make install
cd ..
rm -r jbig2enc
