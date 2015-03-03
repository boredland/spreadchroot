command -v convertfilestopdf >/dev/null 2>&1 || {
wget http://www.leptonica.com/source/leptonica-1.71.tar.gz
tar xvf leptonica-1.71.tar.gz
cd leptonica-1.71/
./autobuild
./configure
make -j
sudo make install
cd ..
}
