#!/bin/bash
if [ "$(whoami)" != "root" ] ; then
	echo "Please run as root"
	exit 1
fi

board_rev_1_2=$1

sudo echo 264 > /sys/class/gpio/export 
sudo echo 396 > /sys/class/gpio/export 
sudo echo out > /sys/class/gpio/gpio264/direction 
sudo echo out > /sys/class/gpio/gpio396/direction 
if $board_rev_1_2; then
	sudo echo 1 > /sys/class/gpio/gpio264/value 
else
	sudo echo 0 > /sys/class/gpio/gpio264/value 
fi
sudo echo 0 > /sys/class/gpio/gpio396/value

sudo gtkterm -p /dev/ttyTHS2 -s 115200

sudo echo 264 > /sys/class/gpio/unexport
sudo echo 396 > /sys/class/gpio/unexport

