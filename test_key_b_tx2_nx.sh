sudo echo 425 > /sys/class/gpio/export
sudo echo out > /sys/class/gpio/gpio425/direction

trap interrupt_func INT
interrupt_func() {
	sudo echo 425 > /sys/class/gpio/unexport
}

watch -n 0.1 lsusb

