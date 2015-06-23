#!/bin/bash
set -x
set -e

git clone https://github.com/agl/jbig2enc
cd jbig2enc
./autogen.sh
./configure
make -j12
make install
cd ..
rm -r jbig2enc
