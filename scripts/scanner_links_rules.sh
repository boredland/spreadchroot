#!/usr/bin/env bash
set -x
set -e
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
sudo rm -f /etc/udev/rules.d/70-persistent-net.rules
if [ "$(stat -c %d:%i /)" != "$(stat -c %d:%i /proc/1/root/.)" ]; then
  echo "We are chrooted!"
else
sudo udevadm control --reload-rules
fi
sudo usermod -a -G plugdev $(whoami)
fi
## Add chdkptp to bash
if grep -q "CHDKPTP_DIR=/usr/local/lib/chdkptp" ~/.bashrc
then
echo "chdkptp already in bashrc."
else
echo "export CHDKPTP_DIR=/usr/local/lib/chdkptp" >> ~/.bashrc 
fi
