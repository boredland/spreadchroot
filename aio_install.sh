##starting from a clean 14.04 system
sudo apt-get update
sudo apt-get upgrade	

##now install all dependcies
sudo apt-get install python2.7 python2.7-dev python-virtualenv \
python-tk idle python-pmw python-imaging \
python-pip libpython2.7-dev libusb-dev \
libjpeg-dev libtiff5-dev libqt4-core ruby-rmagick \
libmagickwand-dev nano \
ruby-hpricot lua5.2 git imagemagick tesseract-ocr* build-essential \
libqt4-dev libjpeg8-dev libjpeg-turbo8-dev libjpeg-dev git \
bash-completion nfs-common ghostscript ruby1.9.1 ruby1.9.1-dev \
rubygems1.9.1 irb1.9.1 ri1.9.1 rdoc1.9.1 libopenssl-ruby1.9.1 libssl-dev \
zlib1g-dev subversion cmake zlib1g-dev libpng12-dev libtiff5-dev \
libboost1.55-all-dev libxrender-dev liblua5.2-dev \
automake libtool -y

##install latest leptonica
command -v leptonica >/dev/null 2>&1 || {
wget http://www.leptonica.com/source/leptonica-1.71.tar.gz
tar xvf leptonica-1.71.tar.gz
cd leptonica-1.71/
./autobuild
./configure
make -j
sudo make install
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
make
sudo make install }

## Next install latest chdkptp.
#wget -O chdkptp-r658-raspbian-gui.zip https://www.assembla.com/spaces/chdkptp/documents/c5q2j8xwmr5jiWacwqjQXA/download/c5q2j8xwmr5jiWacwqjQXA
#command -v chdkptp >/dev/null 2>&1 || {
#  if [[ "$(uname -m)" = "x86_64" ]]
#  then
# wget -O chdkptp-r658-Linux-x86_64.zip https://www.assembla.com/spaces/chdkptp/documents/bEQP3wxwir5ikeacwqEsg8/download/bEQP3wxwir5ikeacwqEsg8
#sudo unzip chdkptp-r658-Linux-x86_64.zip -d /usr/local/lib/chdkptp
#fi
#}

##install latest canvas draw, mine was 5.8
#if [[ "$(uname -m)" = "x86_64" ]]
#then
#  wget http://downloads.sourceforge.net/project/canvasdraw/5.8/Linux%20Libraries/cd-5.8_Linux35_64_lib.tar.gz
#  sudo tar zxf cd-5.8_Linux35_64_lib.tar.gz -C /usr/local/lib/chdkptp
#fi

##next install IUP - portable user interface in the latest version, mine was 3.11
#if [[ "$(uname -m)" = "x86_64" ]]
#then
#wget http://downloads.sourceforge.net/project/iup/3.11/Linux%20Libraries/iup-3.11_Linux35_64_lib.tar.gz
#sudo tar zxf iup-3.11_Linux35_64_lib.tar.gz -C /usr/local/lib/chdkptp
#fi
##create and open a new file
if grep -q /usr/local/lib/chdkptp/ "/etc/ld.so.conf.d/spreads.conf"; then
sudo sh -c "echo '/usr/local/lib/chdkptp/' >> /etc/ld.so.conf.d/spreads.conf"
fi

##reload the system-wide libraries paths
sudo ldconfig

##now install libyaml
wget http://pyyaml.org/download/libyaml/yaml-0.1.5.tar.gz
tar xvf yaml-0.1.5.tar.gz
cd yaml-0.1.5
./configure
make -j
sudo make install

##finally install spreads in an virtualenv, create a new one
virtualenv ~/.spreads
source ~/.spreads/bin/activate

##install further dependancies for spreads (ignore warnings)
sudo apt-get install python-psutil libffi-dev python-usb libturbojpeg -y

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

## check if chdkptp is working
#/usr/local/lib/chdkptp/chdkptp
exit 0
