#!/usr/bin/env bash
set -x
set -e
turbojpeg=`sudo find / -type f -name "libturbojpeg.so.0.0.0"`
if [[ ! -f /usr/lib/x86_64-linux-gnu/libturbojpeg.so ]]; then
sudo ln -s $turbojpeg ${turbojpeg%.0.0.0}
fi
