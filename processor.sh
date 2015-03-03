#!/usr/bin/env bash
set -e
set -x
## get number of cores
threads=`cat /proc/cpuinfo | grep processor | wc -l`
threads=$((threads - 1))
## general depencies
sudo apt-get install python2.7-dev python-pip build-essential \
pkg-config libffi-dev libmagickwand-dev python-cffi libturbojpeg -y
## building depencies
sudo apt-get install automake cmake libqt4-dev libboost1.55-all-dev -y

## Compile and install latest leptonica
./scripts/leptonica.sh $threads

## Compile install tesseract from git
./scripts/tesseract.sh $threads

## Compile and install jbig2enc
./scripts/jbig2enc.sh $threads

## Install pdfbeads
./scripts/pdfbeads.sh $threads

## Install latest djvubind
./scripts/djvubind.sh $threads

## Install Scantailor
./scripts/scantailor.sh $threads

exit 0
