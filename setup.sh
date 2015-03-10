#!/usr/bin/env bash
#set -e
# Redirect stdout ( > ) into a named pipe ( >() ) running "tee"
exec > >(tee $(date +%F)_$(date +"%I-%M-%S")_spreads_deploy_log.txt)
exec 2>&1
SCRIPTPATH="$( cd "$( echo "${BASH_SOURCE[0]%/*}" )" && pwd )"
if [[ $1 == "" ]]
then
echo "Do you want to install Standalone [1], Processing [2] or Full [3]: "
read mode
else 
mode=$1
fi

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
./scripts/fix_turbojpeg.sh
./scripts/spreads.sh $mode

## Extend Spreads for Standalone and Full Setups
if [[ $mode == 2 ]]
then
echo "## Will neither install chdkptp, nor gphoto2."
else
## I think some of those packages installed are depencies mentioned by spreads later and could be skipped...
sudo apt-get install liblua5.2-dev libusb-dev libgphoto2-dev libhidapi-dev -y
sudo pip install lupa --install-option="--no-luajit"
sudo pip install enum34 gphoto2-cffi hidapi-cffi
./scripts/scanner_links_rules.sh
sudo pip install "http://buildbot.diybookscanner.org/nightly/spreads-latest.tar.gz#egg=spreads[web,chdkcamera,hidtrigger,gphoto2camera]"
fi

## Install Config files
if [[ $mode == 1 ]] 
then
cp files/standalone.yaml ~/.config/spreads/config.yaml
echo "## Installed Config for chdkptp, if you want gphoto please re-run spread configure."
fi

if [[ $mode == 2 ]] 
then
cp files/processor.yaml ~/.config/spreads/config.yaml
fi

if [[ $mode == 3 ]] 
then
cp files/full.yaml ~/.config/spreads/config.yaml
echo "## Installed Config for chdkptp, if you want gphoto please re-run spread configure."
fi

## Adding a Startup-Script
sudo cp files/spread /etc/init.d/spread
sudo chmod a+x /etc/init.d/spread

exit 0
