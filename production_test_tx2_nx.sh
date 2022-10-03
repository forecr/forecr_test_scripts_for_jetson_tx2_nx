#!/bin/bash
if [ "$(whoami)" != "root" ] ; then
	echo "Please run as root"
	echo "Quitting ..."
	exit 1
fi

# Check the board revision
board_rev_1_2=false
read -p 'Is it DSBOARD-NX2 Rev-1.2 (y/n) [Default: n] ' board_rev
case $board_rev in
	[Yy]* )
		board_rev_1_2=true
		echo "Selecting 'y'"
		;;
	[Nn]* )
		board_rev_1_2=false
		echo "Selecting 'n'"
		;;
	* )
		echo "Selecting default value"
		;;
esac


# Check the scipts' folder
SCRIPTS_FOLDER=${PWD}
if [ $# -eq 1 ]; then
	SCRIPTS_FOLDER=$1
fi
if [ $# -gt 1 ]; then
	echo "Please type test scripts' folder path"
	echo "Please run as:"
	echo "sudo $0 <test_scripts'_full_path>"
	echo "Quitting ..."
	exit 1
fi
if [ -d "$SCRIPTS_FOLDER" ]; then
	if [ "${SCRIPTS_FOLDER: -1}" != "/" ]; then
		SCRIPTS_FOLDER="$SCRIPTS_FOLDER/"
	fi
	echo "$SCRIPTS_FOLDER folder exists"
	chmod +x $SCRIPTS_FOLDER/iperf3_*.sh
	chmod +x $SCRIPTS_FOLDER/test_*.sh
	echo "All script files made executable"
else
	echo "$SCRIPTS_FOLDER folder does not exist"
	echo "Quitting ..."
	exit 1
fi

# Check GtkTerm installed
REQUIRED_PKG="gtkterm"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
echo "Checking for $REQUIRED_PKG: $PKG_OK"
if [ "" = "$PKG_OK" ]; then
	echo ""
	echo "$REQUIRED_PKG not found. Setting it up..."
	sudo apt-get --yes install $REQUIRED_PKG 

	PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
	echo ""
	echo "Checking for $REQUIRED_PKG: $PKG_OK"

	if [ "" = "$PKG_OK" ]; then
		echo ""
		echo "$REQUIRED_PKG not installed. Please try again later"
		exit 1
	fi

fi

function check_nvgetty_service {
	echo -n "nvgetty.service status: "
	if [ "$(systemctl is-enabled nvgetty.service)" = "enabled" ]; then 
		echo "enabled"
		sleep 2
		sudo systemctl disable nvgetty.service
		echo "Service disabled, rebooting now ..."
		sleep 10
		sudo reboot
	elif [ "$(systemctl is-enabled nvgetty.service)" = "disabled" ]; then
		echo "disabled"
	else 
		echo "ERROR"
		echo "Failed to get unit file state -> No such file or directory"
		exit 1
	fi
}


function test_menu {
	continue_test=true

	while $continue_test; do
		sleep 1
		echo ""
		echo "****************************"
		echo "*** Production Test Menu ***"
		echo "1) Previous Tests"
		echo "2) Disks (M.2 SSD and SD card) Test"
		echo "3) Network Speed Test"
		echo "4) Local Network Test (iperf3)"
		echo "5) Public Network Test (ping)"
		echo "6) USB Test"
		echo "7) CSI Test"
		echo "8) M.2 Key-E Test" 
		echo "9) M.2 Key-B Test"
		echo "10) RS-232 Test"
		echo "11) RS-422 Test"
		echo "12) RS-485 Write Test"
		echo "13) RS-485 Read Test"
		echo "14) CAN Bus (Transmit) Test"
		echo "15) CAN Bus (Receive) Test"
		echo "16) Digital Out Test"
		echo "17) Digital In-0 Test"
		echo "18) Digital In-1 Test"
		echo "19) Fan Test"
		read -p "Type the test number (or quit) [1/.../q]: " choice
		echo ""

		case $choice in
			1 ) 
				echo "* Check The power button"
				echo "* Set the device in recovery mode, connect recovery USB and check the device in recovery mode with lsusb (0955:7c18)"
				echo "* Reset the device, connect Debug USB and check the serial connection"
				;;
			2 )
				echo "Check M.2 SSD and SD card detected"
				gnome-terminal -- gnome-disks
				;;
			3 )
				echo "Network Speed Test"
				gnome-terminal -- $SCRIPTS_FOLDER/test_net_speed.sh
				;;
			4 )
				echo "Local Network Test"
				read -p "Server or Client (s/c): " network_choice
				case $network_choice in
					[Ss]* )
						gnome-terminal -- $SCRIPTS_FOLDER/iperf3_server.sh
						;;
					[Cc]* )
						gnome-terminal -- $SCRIPTS_FOLDER/iperf3_client.sh
						;;
					* )
						echo "Wrong choice"
						;;
				esac
				;;
			5 )
				echo "Public Network Test"
				gnome-terminal -- $SCRIPTS_FOLDER/test_public_net.sh
				;;
			6 )
				echo "USB Test"
				gnome-terminal -- watch -n 0.1 lsusb
				;;
			7 )
				echo "CSI Test"
				gnome-terminal -- $SCRIPTS_FOLDER/test_csi_1.sh
				sleep 2
				gnome-terminal -- $SCRIPTS_FOLDER/test_csi_2.sh
				;;
			8 )
				echo "Key-E Test"
				sudo gnome-terminal -- watch -n 0.1 lspci
				sudo gnome-terminal -- watch -n 0.1 lsusb
				;;
			9 )
				echo "Key-B Test"
				sudo gnome-terminal -- $SCRIPTS_FOLDER/test_key_b_tx2_nx.sh
				;;
			10 )
				echo "RS232 Test"
				check_nvgetty_service
				sudo gnome-terminal -- $SCRIPTS_FOLDER/test_rs232_tx2_nx.sh $board_rev_1_2
				;;
			11 )
				echo "RS422 Test"
				check_nvgetty_service
				sudo gnome-terminal -- $SCRIPTS_FOLDER/test_rs422_tx2_nx.sh $board_rev_1_2
				;;
			12 )
				echo "RS485 Write Test"
				check_nvgetty_service
				sudo gnome-terminal -- $SCRIPTS_FOLDER/test_rs485_write_tx2_nx.sh $board_rev_1_2
				;;
			13 )
				echo "RS485 Read Test"
				check_nvgetty_service
				sudo gnome-terminal -- $SCRIPTS_FOLDER/test_rs485_read_tx2_nx.sh $board_rev_1_2
				;;
			14 )
				echo "CANBus Transmit Test"
				sudo gnome-terminal -- $SCRIPTS_FOLDER/test_can_transmit_tx2_nx.sh
				;;
			15 )
				echo "CANBus Receive Test"
				sudo gnome-terminal -- $SCRIPTS_FOLDER/test_can_receive_tx2_nx.sh
				;;
			16 )
				echo "Digital Out Test"
				sudo gnome-terminal -- $SCRIPTS_FOLDER/test_digital_out_multi_tx2_nx.sh
				;;
			17 )
				echo "Digital In-0 Test"
				sudo gnome-terminal -- $SCRIPTS_FOLDER/test_digital_in0_tx2_nx.sh
				;;
			18 )
				echo "Digital In-1 Test"
				sudo gnome-terminal -- $SCRIPTS_FOLDER/test_digital_in1_tx2_nx.sh
				;;
			19 )
				echo "Fan Test"
				sudo gnome-terminal -- $SCRIPTS_FOLDER/test_fan.sh
				;;
			[Qq]* )
				echo "Quitting ..."
				exit 1
				;;
			* )
				echo "Wrong choice"
				;;
		esac
	done
}


test_menu

