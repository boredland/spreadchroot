#!/usr/bin/env bash
set -x
platform='unknown'
unamestr=`uname -i`
if [[ "$unamestr" == 'x86_64' ]]; then
  sudo ln -s /usr/lib/x86_64-linux-gnu/libturbojpeg.so.0.0.0 /usr/lib/x86_64-linux-gnu/libturbojpeg.so
else if [[ "$unamestr" == 'armv7l' ]]; then
  sudo ln -s /usr/lib/arm-linux-gnueabihf/libturbojpeg.so.0.0.0 /usr/lib/arm-linux-gnueabihf/libturbojpeg.so
else if [[ "$unamestr" == 'i386' ]]; then
sudo ln -s /usr/lib/i386-linux-gnu/libturbojpeg.so.0.0.0 /usr/lib/i386-linux-gnu/libturbojpeg.so
else then
echo "Sadly there's no patch for your platform. Find libturbojpeg.so.0.0.0 and create sth. like 'sudo ln -s /usr/lib/i386-linux-gnu/libturbojpeg.so.0.0.0 /usr/lib/i386-linux-gnu/libturbojpeg.so
 '"
exit 0
fi
