#!/usr/bin/env bash
set -e
set -x
# Redirect stdout ( > ) into a named pipe ( >() ) running "tee"
exec > >(tee $(date +%F)_$(date +"%I-%M-%S")_spreads_deploy_log.txt)
exec 2>&1
SCRIPTPATH="$( cd "$( echo "${BASH_SOURCE[0]%/*}" )" && pwd )"

echo "Do you want to install for capturing only [1], server only [2] or full [Enter for full]:"
read mode

echo "Please set the number of cores for the c-compiler [Enter for auto]:"
read j

## Aptitude
./scripts/aptitude.sh $mode

## Compile and install latest leptonica
./scripts/leptonica.sh $mode $j

## Compile install tesseract from git
./scripts/tesseract.sh $mode $j

## Compile and install jbig2enc
./scripts/jbig2enc.sh $mode $j

## Install pdfbeads
./scripts/pdfbeads.sh $mode $j

## Install latest djvubind
./scripts/djvubind.sh $mode $j

## Install Scantailor
./scripts/scantailor.sh $mode $j

## Install libyaml
./scripts/libyaml.sh $mode $j

## turbojpeg_fix
./scripts/fix_turbojpeg.sh

##reload the system-wide libraries paths
sudo ldconfig

##finally install spreads in an virtualenv, create a new one
if grep -q "source ~/.spreads/bin/activate" ~/.bashrc
then
echo "## Virtualenv already in bashrc."
else
virtualenv ~/.spreads
source ~/.spreads/bin/activate
echo "source ~/.spreads/bin/activate" >> ~/.bashrc
fi
pip install pycparser 
pip install cffi 
pip install jpegtran-cffi
pip install --upgrade --pre pyusb
pip install --install-option='--no-luajit' lupa

##enable spreads GUI packages by installing PySide and fixing symbolic link problem
## I think noone needs the gui anymore.
##sudo ln -s /usr/lib/python2.7/dist-packages/PySide ~/.spreads/lib/python2.7/site-packages/PySide
## Add lua to bashrc
if grep -q "LUA_PATH="$CHDKPTP_DIR/lua/?.lua"" ~/.bashrc
then
echo "## Lua already in bashrc."
else
echo "export LUA_PATH="$CHDKPTP_DIR/lua/?.lua"" >> ~/.bashrc 
fi

##add current user to staff group  (the word ´username´ must be replaced by the current username)
sudo adduser $(whoami) staff

## type 
source ~/.bashrc

##we need some more python modules for the spread web plugin
pip install Flask tornado requests waitress zipstream Wand Flask-Compress

##now install spreads
wget http://buildbot.diybookscanner.org/nightly/spreads-latest.tar.gz
tar xvf spreads-latest.tar.gz
cd spreads-*
pip install .
pip install -e ".[web]"
if [[ ! $1 == 2 ]]
then 
pip install -e ".[hidtrigger]"
pip install chdkptp.py
fi
cd ..

## Create chdkptp symlink
./scripts/scanner_links_rules.sh $mode
## Create Spreads config folder
mkdir ~/.config
mkdir ~/.config/spreads
##Kill gphoto.
pkill -9 gphoto2

echo Now run spread configure
echo I suggest you activate: autorotate, djvubind, hidtrigger, pdfbeads, scantailor, tesseract, web
echo Lateron, after a reboot, start spreads via \"spread web\" and open any browser with "[YOURIP]:5000"
echo If you dont want to disable gphoto2 permanently I suggest you type in "pkill -9 gphoto2" before you power on your cameras.
exit 0
