#!/bin/bash
read -p "Enter the IP address of iPerf3 server: " network_address
echo "Step (1/4)" && \
iperf3 -c $network_address && \
echo "Step (2/4)" && \
iperf3 -c $network_address -R && \
echo "Step (3/4)" && \
iperf3 -c $network_address -u -b 1000M && \
echo "Step (4/4)" && \
iperf3 -c $network_address -u -b 1000M -R 
read -p "Press [Enter] to exit" quit_key
