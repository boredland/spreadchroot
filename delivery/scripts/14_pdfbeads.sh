#!/usr/bin/env bash
set -x
set -e

git clone https://github.com/ifad/pdfbeads
cd pdfbeads
gem build pdfbeads.gemspec 
gem install pdfbeads-*.gem
cd ..
rm -r pdfbeads
