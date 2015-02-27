#!/usr/bin/env bash
#set -e
set -x
# Redirect stdout ( > ) into a named pipe ( >() ) running "tee"
exec > >(tee $(date +%F)_$(date +"%I-%M-%S")_spreads_deploy_log.txt)
exec 2>&1
##starting from a clean 14.04 system
sudo apt-get update
sudo apt-get upgrade	
SCRIPTPATH="$( cd "$( echo "${BASH_SOURCE[0]%/*}" )" && pwd )"
##now install all dependcies
sudo apt-get install python2.7 python2.7-dev python-virtualenv \
python-tk idle python-pmw python-imaging \
python-pip libpython2.7-dev libusb-dev \
libjpeg-dev libtiff5-dev libqt4-core ruby-rmagick \
libmagickwand-dev lua5.2 liblua5.2-dev \
ruby-hpricot git imagemagick build-essential \
libqt4-dev libjpeg8-dev libjpeg-turbo8-dev libjpeg-dev git \
ghostscript ruby1.9.1 ruby1.9.1-dev rubygems1.9.1 \
irb1.9.1 ri1.9.1 rdoc1.9.1 libopenssl-ruby1.9.1 libssl-dev \
zlib1g-dev cmake zlib1g-dev libpng12-dev libtiff5-dev \
libboost1.55-all-dev libxrender-dev libturbojpeg \
automake libtool libpango1.0-dev python-psutil libffi-dev -y
##python-usb has some depency-error

##install latest leptonica
command -v convertfilestopdf >/dev/null 2>&1 || {
wget http://www.leptonica.com/source/leptonica-1.71.tar.gz
tar xvf leptonica-1.71.tar.gz
cd leptonica-1.71/
./autobuild
./configure
make -j
sudo make install
}
## install tesseract from git
command -v tesseract >/dev/null 2>&1 || {
if [[ ! -d tesseract-ocr ]]
then
git clone https://code.google.com/p/tesseract-ocr/
fi
cd tesseract-ocr/tessdata
## check if the trainingfiles are there and if not add them from git
if [[ ! -f deu.traineddata ]]
then
git clone https://code.google.com/p/tesseract-ocr.tessdata/ tessdata
cp tessdata/* .
sudo rm -r tessdata
cd ..
else 
cd ..
fi
git pull
./autogen.sh
./configure
make -j
sudo make install
make -j training
sudo make training-install
sudo make install LANGS=
cd ..
}
##Install jbig2enc
command -v jbig2 >/dev/null 2>&1 || {
git clone https://github.com/agl/jbig2enc
cd jbig2enc
./autogen.sh
./configure
make -j
sudo make install
cd ..
}

##next install pdfbeads
command -v pdfbeads >/dev/null 2>&1 || {
git clone https://github.com/ifad/pdfbeads
cd pdfbeads
gem build pdfbeads.gemspec 
sudo gem install pdfbeads-1.0.11.gem
cd ..
}
##next install latest djvubind
command -v djvubind >/dev/null 2>&1 || {
git clone https://github.com/strider1551/djvubind
cd djvubind
sudo ./setup.py install
cd ..
}

## Install Scantailor
command -v scantailor-cli >/dev/null 2>&1 || {
wget -O scantailor-enhanced-20140214.tar.bz2 http://downloads.sourceforge.net/project/scantailor/scantailor-devel/enhanced/scantailor-enhanced-20140214.tar.bz2
tar xvjf scantailor-enhanced-20140214.tar.bz2
cd scantailor-enhanced
cmake .
make -j
sudo make install
}

##create and open a new file - not necessary I think
if grep -q /usr/local/lib/chdkptp/ "/etc/ld.so.conf.d/spreads.conf"
then
sudo sh -c "echo '/usr/local/lib/chdkptp/' >> /etc/ld.so.conf.d/spreads.conf"
fi

##reload the system-wide libraries paths
sudo ldconfig

##now install libyaml
if [[ ! -f /usr/local/lib/libyaml-* ]]
then
wget http://pyyaml.org/download/libyaml/yaml-0.1.5.tar.gz
tar xvf yaml-0.1.5.tar.gz
cd yaml-0.1.5
./configure
make -j
sudo make install
cd ..
fi

##finally install spreads in an virtualenv, create a new one
virtualenv ~/.spreads
source ~/.spreads/bin/activate

##fix problems with the libturbojpeg dyn lib
sudo ln -s /usr/lib/x86_64-linux-gnu/libturbojpeg.so.0.0.0 /usr/lib/x86_64-linux-gnu/libturbojpeg.so

pip install pycparser 
pip install cffi 
pip install jpegtran-cffi
pip install --upgrade --pre pyusb
pip install --install-option='--no-luajit' lupa

##enable spreads GUI packages by installing PySide and fixing symbolic link problem
sudo apt-get install python-pyside -y
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
pip install chdkptp.py
cd ..
##Kill gphoto.
pkill -9 gphoto2
##now run the spreads configuration program
spread configure
exit 0
