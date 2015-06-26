#!/bin/bash
set -e
set -x

# Install some basic tools and libraries
apt-get -y install --no-install-recommends \
    cifs-utils htop less ntp openssh-server sudo nano \
    build-essential automake \
    ruby-dev rubygems ruby imagemagick libtool libleptonica-dev git-core zlib1g-dev \
    selinux-basics selinux-utils checkpolicy libapol4 libqpol1 policycoreutils psmisc #linux deploy depencies
    
# 
# User spreads should be able to shut the system down (used in web interface)
echo 'spreads ALL=NOPASSWD: /sbin/shutdown' >> /etc/sudoers

# Fix 'unable to resolve host spreadpi' errors
#sed -i -e 's/\(127.0.0.1.*\)/\1 spreadchroot/g' /etc/hosts
