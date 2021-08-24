#!/bin/bash
if [ "$(whoami)" != "root" ] ; then
	echo "Please run as root"
	exit 1
fi

sudo echo 252 > /sys/class/gpio/export
sudo echo out > /sys/class/gpio/gpio252/direction
sudo echo 253 > /sys/class/gpio/export
sudo echo out > /sys/class/gpio/gpio253/direction
sudo echo 254 > /sys/class/gpio/export
sudo echo out > /sys/class/gpio/gpio254/direction

echo "DIGITAL_OUT0 OFF"
echo "DIGITAL_OUT1 OFF"
echo "DIGITAL_OUT2 OFF"
sudo echo 0 > /sys/class/gpio/gpio252/value
sudo echo 0 > /sys/class/gpio/gpio253/value
sudo echo 0 > /sys/class/gpio/gpio254/value

