#!/usr/bin/env bash
set -e
set -x
command -v tesseract >/dev/null 2>&1 || {
if [[ ! -d tesseract-ocr ]]
then
git clone https://code.google.com/p/tesseract-ocr/
fi
cd tesseract-ocr
git pull
./autogen.sh
./configure
make -j$2
sudo make install
cd ..
}
exit 0
## check if the trainingfiles are there and if not add them from git
if [[ ! -d tessdata ]]
then
git clone https://code.google.com/p/tesseract-ocr.tessdata/ tessdata
sudo cp tessdata/* .
sudo rm -r tessdata
cd ..
else 
cd ..
fi
