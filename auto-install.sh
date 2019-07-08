#!/bin/bash
## This script: 
## 	(1) installs git to pull the repository and gcc (and associated build tools)
## 	(2) compiles the driver binary and installs it to the system
## 	(3) creates a udev rule to rename the interface to "wlan0" (optional)
##	(4) loads the driver and adds a modprobe rule to do this at boot
##

## Install Dependencies
apt update
apt install -y git build-essential make autoconf libtool gcc gettext

## Clone latest github repository
cd /opt/
git clone https://github.com/mikysal78/rtl8812AU_8821AU_linux.git

## Compile and install driver binary
cd rtl8812AU_8821AU_linux
make
make install

## Make udev rule (you can omit this line to have the system automatically name the device, or change NAME="wlan0" to a diffrent device name)
#echo 'SUBSYSTEM=="net", ACTION=="add", DRIVERS=="rtl8812au", ATTR{type}=="1", NAME="wlan0"' >> /lib/udev/rules.d/70-persistent-network.rules

## Load driver module
modprobe rtl8812au

## Add module at boot (file may be /etc/modules on other distribution)
echo -e '# Usb wifi dongle\nrtl8812au' > /etc/modules-load.d/rtl8812au.conf
