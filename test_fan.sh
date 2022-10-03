#!/bin/bash
if [ "$(whoami)" != "root" ] ; then
	echo "Please run as root"
	exit 1
fi

echo -n "Current fan PWM: "
cat /sys/devices/pwm-fan/cur_pwm 

echo -n "Setting to 255. "
sudo echo 255 > /sys/devices/pwm-fan/target_pwm 
sleep 15
echo -n "Current fan PWM: "
cat /sys/devices/pwm-fan/cur_pwm 

echo -n "Setting to 0. "
sudo echo 0 > /sys/devices/pwm-fan/target_pwm 
sleep 15
echo -n "Current fan PWM: "
cat /sys/devices/pwm-fan/cur_pwm 

echo -n "Setting to 255. "
sudo echo 255 > /sys/devices/pwm-fan/target_pwm 
sleep 15
echo -n "Current fan PWM: "
cat /sys/devices/pwm-fan/cur_pwm 

echo -n "Setting to 0. "
sudo echo 0 > /sys/devices/pwm-fan/target_pwm 
sleep 15
echo -n "Current fan PWM: "
cat /sys/devices/pwm-fan/cur_pwm 

echo "Done."
