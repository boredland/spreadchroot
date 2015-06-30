#!/usr/bin/env bash
set -x
set -e
apt-get -y remove --purge --auto-remove build-essential automake \
  git-core zlib1g-dev ruby-dev rubygems libtool build-essential \
  automake cmake libffi-dev libturbojpeg-dev libmagickwand-dev \
  libmagickwand-dev libxslt-dev libxml2-dev libgphoto2-dev \
  tesseract-ocr-dev
apt-get -y --force-yes autoremove
apt-get clean
