#!/usr/bin/env bash
set -x
set -e
## get number of cores
threads=`cat /proc/cpuinfo | grep processor | wc -l`
threads=$((threads - 1))
if [[ $threads = 0 ]]
then 
threads=$((threads + 1))
fi
## building depencies
sudo apt-get install automake cmake libqt4-dev libboost1.55-all-dev \
rubygems1.9.1 ruby1.9.1-dev imagemagick -y

## Compile and install latest leptonica
./scripts/leptonica.sh $threads $1

## Compile install tesseract from git
./scripts/tesseract.sh $threads $1

## Compile and install jbig2enc
./scripts/jbig2enc.sh $threads $1

## Install pdfbeads
./scripts/pdfbeads.sh $threads $1

## Install latest djvubind
./scripts/djvubind.sh $threads $1

## Install Scantailor
./scripts/scantailor.sh $threads $1

sudo ldconfig
