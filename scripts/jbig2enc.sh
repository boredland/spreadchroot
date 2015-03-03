echo blubb

set -e
set -x
if [[ $1 == 1 ]]; then exit 0;fi
command -v jbig2 >/dev/null 2>&1 || {
  echo blubb2
git clone https://github.com/agl/jbig2enc
cd jbig2enc
./autogen.sh
./configure
make -j$2
sudo make install
cd ..
}
