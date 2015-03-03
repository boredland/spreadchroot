#!/usr/bin/env bash
set -x
if [[ $1 == 2 ]]; then exit 0;fi
##autoload chdkptp
if grep -q /usr/local/lib/chdkptp/ "/etc/ld.so.conf.d/spreads.conf"
then
sudo sh -c "echo '/usr/local/lib/chdkptp/' >> /etc/ld.so.conf.d/spreads.conf"
fi
## Add udev rule for hidtrigger
if grep -q 'ACTION=="add", SUBSYSTEM=="usb", MODE:="666"' "/etc/udev/rules.d/99-usb.rules"
then
sudo sh -c "echo 'ACTION=="add", SUBSYSTEM=="usb", MODE:="666"' > /etc/udev/rules.d/99-usb.rules"
sed -i -e 's/KERNEL\!="eth\*|/KERNEL\!="/' /lib/udev/rules.d/75-persistent-net-generator.rules
rm -f /etc/udev/rules.d/70-persistent-net.rules
fi
## Add chdkptp to bash
if grep -q "CHDKPTP_DIR=/usr/local/lib/chdkptp" ~/.bashrc
then
echo "export CHDKPTP_DIR=/usr/local/lib/chdkptp" >> ~/.bashrc 
fi
