#!/usr/bin/env bash
set -e
# Redirect stdout ( > ) into a named pipe ( >() ) running "tee"
exec > >(tee $(date +%F)_$(date +"%I-%M-%S")_spreads_deploy_log.txt)
exec 2>&1
SCRIPTPATH="$( cd "$( echo "${BASH_SOURCE[0]%/*}" )" && pwd )"

echo "Do you want to install for capturing only [1], processing-server only [2] or full [Enter for full]: "
read mode

mkdir ~/.config
mkdir ~/.config/spreads
## install general depencies
./scripts/depencies_general.sh
## install processing depencies
if [[ $mode == 1 ]]
then echo "## Will not install processing tools."
else
./processor.sh
fi

## Install spreads
./scripts/spreads.sh

## Install chdkptp
if [[ $mode == 2 ]]
then
echo "## Will neither install chdkptp, nor gphoto2."
else
sudo apt-get install liblua5.2-dev libusb-dev
sudo pip install lupa --install-option="--no-luajit"
sudo pip install chdkptp.py
sudo apt-get install libgphoto2-dev
sudo pip install gphoto2-cffi
fi

## Install Config files
if [[ $mode == 1 ]] 
then
cp files/standalone.yaml ~/.config/spreads/config.yaml
echo "## Installed Config for chdkptp, if you want gphoto please re-run 'spread configure'."
else if [[ $mode == 2 ]] 
then
cp files/processor.yaml ~/.config/spreads/config.yaml
else if [[ $mode == 3 ]] 
cp files/full.yaml ~/.config/spreads/config.yaml
echo "## Installed Config for chdkptp, if you want gphoto please re-run 'spread configure'."
fi
