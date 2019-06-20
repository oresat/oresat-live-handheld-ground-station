#!/bin/sh
sleep 10
echo Shutting down wlan1
ifconfig wlan1 down
sleep 1
iw dev wlan1 del
sleep 1
modprobe -r ath9k_htc
sleep 3
echo Starting up wlan1
modprobe ath9k_htc
sleep 3
ifconfig wlan1 down
sleep 1
echo Enabling monitor mode
iw dev wlan1 set monitor fcsfail otherbss
sleep 1
ifconfig wlan1 up
sleep 1
echo setting frequency to 2422MHz - channel 3 
iwconfig wlan1 channel 3
sleep 3
echo Starting wifi broadcast RX
/root/wifibroadcast/sharedmem_init_rx
sleep 1
/root/wifibroadcast/rx -b 8 -r 2 -f 1400 wlan1 | /root/jpeg_stream_rx_stdin_write_to_file.py
