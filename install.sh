##starting from a clean 14.04 system
sudo apt-get update
sudo apt-get upgrade	

##now install all dependcies
sudo apt-get install python2.7 python2.7-dev python-virtualenv \
python-tk idle python-pmw python-imaging \
python-pip libpython2.7-dev libusb-dev \
libjpeg-dev libtiff5-dev libqt4-core ruby ruby-dev ruby-rmagick \
libmagickwand-dev nano \
ruby-hpricot scantailor lua5.2 git imagemagick tesseract-ocr* -y

##next install pdfbeads
sudo gem install pdfbeads

##next install latest djvubind (for me was 1.2.1)
git clone https://github.com/strider1551/djvubind
cd djvubind
sudo ./setup.py install
cd ..
## Next install latest chdkptp.
wget -O chdkptp-r658-raspbian-gui.zip https://www.assembla.com/spaces/chdkptp/documents/c5q2j8xwmr5jiWacwqjQXA/download/c5q2j8xwmr5jiWacwqjQXA
wget -O chdkptp-r658-Linux-x86_64.zip https://www.assembla.com/spaces/chdkptp/documents/bEQP3wxwir5ikeacwqEsg8/download/bEQP3wxwir5ikeacwqEsg8
sudo unzip chdkptp-r658-Linux-x86_64.zip -d /usr/local/lib/chdkptp

##install latest canvas draw, mine was 5.8
wget http://downloads.sourceforge.net/project/canvasdraw/5.8/Linux%20Libraries/cd-5.8_Linux35_64_lib.tar.gz
sudo tar zxf cd-5.8_Linux35_64_lib.tar.gz -C /usr/local/lib/chdkptp

##next install IUP - portable user interface in the latest version, mine was 3.11
wget http://downloads.sourceforge.net/project/iup/3.11/Linux%20Libraries/iup-3.11_Linux35_64_lib.tar.gz
sudo tar zxf iup-3.11_Linux35_64_lib.tar.gz -C /usr/local/lib/chdkptp

##add the /usr/local/lib/chdkptp path to the systems dynamic library search path

##create and open a new file
sudo nano /etc/ld.so.conf.d/spreads.conf

##add the line
/usr/local/lib/chdkptp/

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
##sudo ln -s /usr/lib/x86_64-linux-gnu/libturbojpeg.so.0.0.0 /usr/lib/x86_64-linux-gnu/libturbojpeg.so

pip install pycparser 
pip install cffi 
pip install jpegtran-cffi
pip install --upgrade --pre pyusb


##enable spreads GUI packages by installing PySide and fixing symbolic link problem
sudo apt-get install python-pyside -y
sudo ln -s /usr/lib/python2.7/dist-packages/PySide ~/.spreads/lib/python2.7/site-packages/PySide

##add current user to staff group  (the word ´username´ must be replaced by the current username)

sudo adduser $(whoami) staff

##ow add the lua env variable to the global path in order that the chdkptp command will work
#!#add check!
echo export CHDKPTP_DIR=/usr/local/lib/chdkptp >> ~/.bashrc 
echo export LUA_PATH="$CHDKPTP_DIR/lua/?.lua" >> ~/.bashrc 
echo source ~/.spreads/bin/activate >> ~/.bashrc 

##open a new shell or type 
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
cd ..


##now run the spreads configuration program

spread configure
```
in the program set

* step 1 select : chdkcamera
* step 2 select : scantailor, tesseract, gui, autorotate, web
* step 3 select : select order - autorotate,scantailor,tesseract 
* step 4 and 5 select : no for both camera questions (target_page and focus)

this will save the config as config.yaml.

now its time to configure the cameras

Before rerunning the spreads config program again first make sure if you can use the 
chdkptp program.

First before using chdkptp in Ubuntu 14.04 you have to kill gphoto in order to gain access to the chdk-enabled cameras otherwise you will not be able to use them (gphoto2 will block access to the cameras for all other processes)
```bash
ps aux | grep gphoto
kill -9 <PID of gphoto2 process>
```

I use the Canon A2200, enable CHDK in your camera 
(click [here](http://chdk.wikia.com/wiki/CHDK_1.2.0_User_Manual) - section Using CHKD), plug in the micro USB after 
enabling (I use firmware update method) than plug in the other USB end into your computer, than run the
chdkptp program to test if it is installed correctly.

```bash
/usr/local/lib/chdkptp/chdkptp
```
now click on Connect button.

If it is running without problems end the program.

Now restart the spread configure program again, enable CHDK in your camera, than connect to the computer
 (if not done already) and configure target_page and focus. Should give no errors if camera and CHDK has been 
setup correctly.
