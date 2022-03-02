sudo echo 425 > /sys/class/gpio/export
sudo echo out > /sys/class/gpio/gpio425/direction
watch -n 0.1 lsusb
sudo echo 425 > /sys/class/gpio/unexport

