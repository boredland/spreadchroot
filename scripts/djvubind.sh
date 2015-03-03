#!/usr/bin/env bash
set -e
set -x
if [[ $1 == 1 ]]; then exit 0;fi
command -v djvubind >/dev/null 2>&1 || {
git clone https://github.com/strider1551/djvubind
cd djvubind
sudo ./setup.py install
cd ..
}
