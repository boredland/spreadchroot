#!/usr/bin/env bash
set -x
set -e
if [[ $1 == 1 ]]; then exit 0;fi
command -v pdfbeads >/dev/null 2>&1 || {
git clone https://github.com/ifad/pdfbeads
cd pdfbeads
gem build pdfbeads.gemspec 
sudo gem install pdfbeads-1.0.11.gem
cd ..
}
