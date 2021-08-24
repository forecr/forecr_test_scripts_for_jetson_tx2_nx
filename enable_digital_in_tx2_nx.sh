#!/bin/bash
if [ "$(whoami)" != "root" ] ; then
	echo "Please run as root"
	exit 1
fi

sudo echo 248 > /sys/class/gpio/export
sudo echo in > /sys/class/gpio/gpio248/direction
sudo echo 249 > /sys/class/gpio/export
sudo echo in > /sys/class/gpio/gpio249/direction

