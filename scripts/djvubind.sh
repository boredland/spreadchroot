#!/usr/bin/env bash
set -e
set -x
command -v djvubind >/dev/null 2>&1 || {
git clone https://github.com/strider1551/djvubind
cd djvubind
sudo ./setup.py install
cd ..
}
