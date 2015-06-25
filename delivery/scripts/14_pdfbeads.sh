#!/usr/bin/env bash
set -x
set -e
apt-get -y --force-yes install libmagickwand-dev libxslt-dev libxml2-dev ruby-nokogiri
gem install --local $DELIVERY_DIR/files/iconv-1.0.4-arm-linux.gem
gem install --local $DELIVERY_DIR/files/rmagick-2.15.2-arm-linux.gem
gem install --local $DELIVERY_DIR/files/pdfbeads-1.0.11.gem
#git clone https://github.com/ifad/pdfbeads
#cd pdfbeads
#gem build pdfbeads.gemspec 
#gem install pdfbeads-*.gem
#cd ..
#rm -r pdfbeads
