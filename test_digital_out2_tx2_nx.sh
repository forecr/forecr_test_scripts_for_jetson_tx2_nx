#!/bin/bash
if [ "$(whoami)" != "root" ] ; then
	echo "Please run as root"
	exit 1
fi

step_count=0
test_number=4
sleep_time=1

step_count=$(($step_count+1))
echo "step: $step_count/$test_number"
echo "DIGITAL_OUT0 ON"
sudo echo 1 > /sys/class/gpio/gpio254/value
sleep $sleep_time

step_count=$(($step_count+1))
echo "step: $step_count/$test_number"
echo "DIGITAL_OUT0 OFF"
sudo echo 0 > /sys/class/gpio/gpio254/value
sleep $sleep_time

step_count=$(($step_count+1))
echo "step: $step_count/$test_number"
echo "DIGITAL_OUT0 ON"
sudo echo 1 > /sys/class/gpio/gpio254/value
sleep $sleep_time

step_count=$(($step_count+1))
echo "step: $step_count/$test_number"
echo "DIGITAL_OUT0 OFF"
sudo echo 0 > /sys/class/gpio/gpio254/value

