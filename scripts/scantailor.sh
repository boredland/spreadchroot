#!/usr/bin/env bash
set -e
set -x
command -v scantailor-cli >/dev/null 2>&1 || {
wget -O scantailor-enhanced-20140214.tar.bz2 http://downloads.sourceforge.net/project/scantailor/scantailor-devel/enhanced/scantailor-enhanced-20140214.tar.bz2
tar xvjf scantailor-enhanced-20140214.tar.bz2
cd scantailor-enhanced
cmake .
make -j
sudo make install
}
