#!/usr/bin/env bash
set -x
##autoload chdkptp
if grep -q /usr/local/lib/chdkptp/ "/etc/ld.so.conf.d/spreads.conf"
then
echo "## Already inserted /etc/ld.so.conf.d/spreads.conf"
else
sudo sh -c "echo '/usr/local/lib/chdkptp/' >> /etc/ld.so.conf.d/spreads.conf"
fi
## Add udev rule for hidtrigger
if grep -q 'ACTION=="add", SUBSYSTEM=="usb", MODE:="666"' "/etc/udev/rules.d/99-usb.rules"
then
echo "## Udev-Rule already applied."
else
sudo sh -c "echo 'ACTION=="add", SUBSYSTEM=="usb", MODE:="666"' > /etc/udev/rules.d/99-usb.rules"
sudo sed -i -e 's/KERNEL\!="eth\*|/KERNEL\!="/' /lib/udev/rules.d/75-persistent-net-generator.rules
rm -f /etc/udev/rules.d/70-persistent-net.rules
sudo udevadm control --reload-rules
sudo usermod -a -G plugdev $(whoami)
fi
## Add chdkptp to bash
if grep -q "CHDKPTP_DIR=/usr/local/lib/chdkptp" ~/.bashrc
then
echo "chdkptp already in bashrc."
else
echo "export CHDKPTP_DIR=/usr/local/lib/chdkptp" >> ~/.bashrc 
fi
