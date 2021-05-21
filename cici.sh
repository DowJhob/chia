#!/bin/bash
apt-get update
apt-get upgrade -y

apt-get install xserver-xorg-video-dummy
echo 
'Section "Monitor"
        Identifier "dummy_monitor"
        HorizSync 28.0-80.0
        VertRefresh 48.0-75.0
        Modeline "1920x1080" 172.80 1920 2040 2248 2576 1080 1081 1084 1118
EndSection

Section "Device"
        Identifier "dummy_card"
        VideoRam 256000
        Driver "dummy"
EndSection

Section "Screen"
        Identifier "dummy_screen"
        Device "dummy_card"
        Monitor "dummy_monitor"
        SubSection "Display"
        EndSubSection
EndSection' >  /etc/X11/xorg.conf

echo "Install Git"
apt install git -y

echo "Install chia"
git clone https://github.com/Chia-Network/chia-blockchain.git -b latest --recurse-submodules
cd chia-blockchain
sh install.sh
. ./activate

echo "Install plotman"
pip install --force-reinstall git+https://github.com/ericaltendorf/plotman@main
plotman config generate