#!/usr/bin/env bash
set -x
set -e

#git clone https://code.google.com/p/tesseract-ocr/
#cd tesseract-ocr
#git pull
#./autogen.sh
#./configure
#make -j$CORES
#make install
#cd ..
#rm -r tesseract-ocr
#git clone https://code.google.com/p/tesseract-ocr.tessdata/ tessdata
#cp tessdata/* /usr/local/share/tessdata
#rm -r tessdata
apt-get -y --force-yes install tesseract-ocr tesseract-ocr-*
