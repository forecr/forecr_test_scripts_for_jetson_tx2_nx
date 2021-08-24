#!/bin/bash
if [ "$(whoami)" != "root" ] ; then
	echo "Please run as root"
	exit 1
fi

sudo echo 0 > /sys/class/gpio/gpio252/value
sudo echo 0 > /sys/class/gpio/gpio253/value
sudo echo 0 > /sys/class/gpio/gpio254/value

step_count=0
test_number=14
sleep_time=0.3

#Single Test
step_count=$(($step_count+1))
echo "step: $step_count/$test_number"
echo "DIGITAL_OUT0 ON"
sudo echo 1 > /sys/class/gpio/gpio252/value
sleep $sleep_time

step_count=$(($step_count+1))
echo "step: $step_count/$test_number"
echo "DIGITAL_OUT0 OFF"
sudo echo 0 > /sys/class/gpio/gpio252/value
sleep $sleep_time

step_count=$(($step_count+1))
echo "step: $step_count/$test_number"
echo "DIGITAL_OUT1 ON"
sudo echo 1 > /sys/class/gpio/gpio253/value
sleep $sleep_time

step_count=$(($step_count+1))
echo "step: $step_count/$test_number"
echo "DIGITAL_OUT1 OFF"
sudo echo 0 > /sys/class/gpio/gpio253/value
sleep $sleep_time

step_count=$(($step_count+1))
echo "step: $step_count/$test_number"
echo "DIGITAL_OUT2 ON"
sudo echo 1 > /sys/class/gpio/gpio254/value
sleep $sleep_time

step_count=$(($step_count+1))
echo "step: $step_count/$test_number"
echo "DIGITAL_OUT2 OFF"
sudo echo 0 > /sys/class/gpio/gpio254/value
sleep $sleep_time

#Double Test
step_count=$(($step_count+1))
echo "step: $step_count/$test_number"
echo "DIGITAL_OUT0 ON"
echo "DIGITAL_OUT1 ON"
sudo echo 1 > /sys/class/gpio/gpio252/value
sudo echo 1 > /sys/class/gpio/gpio253/value
sleep $sleep_time

step_count=$(($step_count+1))
echo "step: $step_count/$test_number"
echo "DIGITAL_OUT0 OFF"
echo "DIGITAL_OUT1 OFF"
sudo echo 0 > /sys/class/gpio/gpio252/value
sudo echo 0 > /sys/class/gpio/gpio253/value
sleep $sleep_time

step_count=$(($step_count+1))
echo "step: $step_count/$test_number"
echo "DIGITAL_OUT1 ON"
echo "DIGITAL_OUT2 ON"
sudo echo 1 > /sys/class/gpio/gpio253/value
sudo echo 1 > /sys/class/gpio/gpio254/value
sleep $sleep_time

step_count=$(($step_count+1))
echo "step: $step_count/$test_number"
echo "DIGITAL_OUT1 OFF"
echo "DIGITAL_OUT2 OFF"
sudo echo 0 > /sys/class/gpio/gpio253/value
sudo echo 0 > /sys/class/gpio/gpio254/value
sleep $sleep_time

step_count=$(($step_count+1))
echo "step: $step_count/$test_number"
echo "DIGITAL_OUT0 ON"
echo "DIGITAL_OUT2 ON"
sudo echo 1 > /sys/class/gpio/gpio252/value
sudo echo 1 > /sys/class/gpio/gpio254/value
sleep $sleep_time

step_count=$(($step_count+1))
echo "step: $step_count/$test_number"
echo "DIGITAL_OUT0 OFF"
echo "DIGITAL_OUT2 OFF"
sudo echo 0 > /sys/class/gpio/gpio252/value
sudo echo 0 > /sys/class/gpio/gpio254/value
sleep $sleep_time

#Triple Test
step_count=$(($step_count+1))
echo "step: $step_count/$test_number"
echo "DIGITAL_OUT0 ON"
echo "DIGITAL_OUT1 ON"
echo "DIGITAL_OUT2 ON"
sudo echo 1 > /sys/class/gpio/gpio252/value
sudo echo 1 > /sys/class/gpio/gpio253/value
sudo echo 1 > /sys/class/gpio/gpio254/value
sleep $sleep_time

step_count=$(($step_count+1))
echo "step: $step_count/$test_number"
echo "DIGITAL_OUT0 OFF"
echo "DIGITAL_OUT1 OFF"
echo "DIGITAL_OUT2 OFF"
sudo echo 0 > /sys/class/gpio/gpio252/value
sudo echo 0 > /sys/class/gpio/gpio253/value
sudo echo 0 > /sys/class/gpio/gpio254/value

