#!/usr/bin/env bash
set -e
set -x
if [[ ! -f /usr/local/lib/libyaml-0.so.2.0.3 ]]
then
wget http://pyyaml.org/download/libyaml/yaml-0.1.5.tar.gz
tar xvf yaml-0.1.5.tar.gz
cd yaml-0.1.5
./configure
make -j$2
sudo make install
cd ..
fi
