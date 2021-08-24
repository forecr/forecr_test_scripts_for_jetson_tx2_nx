#!/bin/bash
if [ "$(whoami)" != "root" ] ; then
	echo "Please run as root"
	exit 1
fi

sudo echo 0 > /sys/class/gpio/gpio340/value
sudo echo 1 > /sys/class/gpio/gpio264/value
sudo echo 1 > /sys/class/gpio/gpio396/value
#sudo gtkterm -p /dev/ttyTHS2 -s 115200 -w RS485
