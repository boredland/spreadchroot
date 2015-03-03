#!/usr/bin/env bash
set -x
# Redirect stdout ( > ) into a named pipe ( >() ) running "tee"
exec > >(tee $(date +%F)_$(date +"%I-%M-%S")_spreads_deploy_log.txt)
exec 2>&1
SCRIPTPATH="$( cd "$( echo "${BASH_SOURCE[0]%/*}" )" && pwd )"

echo "Do you want to install for capturing only[1], server only [2] or full [3]:"
read mode

echo "Please set the number of cores for the c-compiler:"
read j

## aptitude
./scripts/aptitude.sh $mode

##Compile and install latest leptonica
./scripts/leptonica.sh $mode $j

##Compile install tesseract from git
./scripts/tesseract.sh $mode $j

##Compile and install jbig2enc
./scripts/jbig2enc.sh $mode $j

##next install pdfbeads
./scripts/pdfbeads.sh $mode $j

##next install latest djvubind
./scripts/djvubind.sh $mode $j

## Install Scantailor
./scripts/scantailor.sh $mode $j

##now install libyaml
./scripts/libyaml.sh $mode $j

##create and open a new file - not necessary I think
if grep -q /usr/local/lib/chdkptp/ "/etc/ld.so.conf.d/spreads.conf"
then
sudo sh -c "echo '/usr/local/lib/chdkptp/' >> /etc/ld.so.conf.d/spreads.conf"
fi

## Add udev rule for hidtrigger
if grep -q 'ACTION=="add", SUBSYSTEM=="usb", MODE:="666"' "/etc/udev/rules.d/99-usb.rules"
then
sudo sh -c "echo 'ACTION=="add", SUBSYSTEM=="usb", MODE:="666"' > /etc/udev/rules.d/99-usb.rules"
sed -i -e 's/KERNEL\!="eth\*|/KERNEL\!="/' /lib/udev/rules.d/75-persistent-net-generator.rules
rm -f /etc/udev/rules.d/70-persistent-net.rules
fi
##reload the system-wide libraries paths
sudo ldconfig

##finally install spreads in an virtualenv, create a new one
virtualenv ~/.spreads
source ~/.spreads/bin/activate

pip install pycparser 
pip install cffi 
pip install jpegtran-cffi
pip install --upgrade --pre pyusb
pip install --install-option='--no-luajit' lupa

##enable spreads GUI packages by installing PySide and fixing symbolic link problem
sudo ln -s /usr/lib/python2.7/dist-packages/PySide ~/.spreads/lib/python2.7/site-packages/PySide

##add current user to staff group  (the word ´username´ must be replaced by the current username)
sudo adduser $(whoami) staff
##ow add the lua env variable to the global path in order that the chdkptp command will work
#!#add check!
echo "export CHDKPTP_DIR=/usr/local/lib/chdkptp" >> ~/.bashrc 
echo "export LUA_PATH="$CHDKPTP_DIR/lua/?.lua"" >> ~/.bashrc 
echo "source ~/.spreads/bin/activate" >> ~/.bashrc 
## type 
source ~/.bashrc
##we need some more python modules for the spread web plugin
pip install Flask
pip install tornado
pip install requests
pip install waitress
pip install zipstream
pip install Wand
pip install Flask-Compress
##now install spreads
wget http://buildbot.diybookscanner.org/nightly/spreads-latest.tar.gz
tar xvf spreads-latest.tar.gz
cd spreads-*
pip install .
pip install -e ".[web]"
pip install -e ".[hidtrigger]"
pip install chdkptp.py
cd ..
##Kill gphoto.
pkill -9 gphoto2

echo Now run spread configure
echo I suggest you activate: autorotate, djvubind, hidtrigger, pdfbeads, scantailor, tesseract, web
echo Lateron, after a reboot, start spreads via \"spread web\" and open any browser with "[YOURIP]:5000"
echo If you dont want to disable gphoto2 permanently I suggest you type in "pkill -9 gphoto2" before you power on your cameras.
exit 0
