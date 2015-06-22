#!/usr/bin/env bash
set -e
set -x

git clone https://github.com/strider1551/djvubind
cd djvubind
./setup.py install
cd ..
rm -r djvubind
