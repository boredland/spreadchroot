#!/usr/bin/env bash
set -x
set -e

git clone https://github.com/ifad/pdfbeads
cd pdfbeads
gem build pdfbeads.gemspec 
gem install pdfbeads-1.0.11.gem
cd ..
rm -r pdfbeads
