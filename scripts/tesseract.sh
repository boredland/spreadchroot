#!/usr/bin/env bash
set -x
command -v tesseract >/dev/null 2>&1 || {
git clone https://code.google.com/p/tesseract-ocr/
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
