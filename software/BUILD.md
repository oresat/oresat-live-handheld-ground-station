# Development Hardware
Some packages will need to be installed, which will require Internet access.  We recommend developing on a Raspberry Pi version which has onboard Ethernet.
Alternately, you can use a USB Ethernet dongle on a Raspberry Pi Zero W.  A USB to serial cable such as [Adafruit product 954](https://www.adafruit.com/product/954) is also recommended.

# Theory of Operation
On boot up /etc/rc.local calls /root/oresat_hgs.sh

oresat_hgs.sh puts the USB AR9721 wifi module into monitor mode on channel 3, then starts wifibroadcast rx and jpeg_stream_rx_stdin_write_to_file.py.

jpeg_stream_rx_stdin_write_to_file.py reads stdin searching for a start of image preamble of 10 or more \AA characters.  Once the preamble has completed the OreSat Live image transfer header is processed to determine the length and MD5 hash of the image.  If the computed MD5 hash of the recieved image matches the transmitted hash the file is written to /tmp/latest.jpg  

OreSat HGS is configured to act as a wifi access point providing an unsecured wireless network named "OreSatLive".  Users wanting to view the OreSat Live image stream will connect to this network.  The DNS, DHCP, and HTTP server settings have been configured so that clients connecting will identify the network as a hotspot requiring the user to sign-in for Internet access.  When the user chooses to sign-in the are presented with the OreSat Live web interface. 

The OreSat Live web site is hosted by the nginx web server with the conntet stored at /var/www/html/  A symlink for /tmp/latest.jpg to /var/www/html/latest.jpg connects the web server to the latest available image.

The web page being served to the clients requests latest.jpg once per second.

# Install Raspbian on SD Card
Download [2018-11-13-raspbian-stretch-lite.img](https://downloads.raspberrypi.org/raspbian_lite/images/raspbian_lite-2018-11-15/2018-11-13-raspbian-stretch-lite.zip)

Install the Raspian Lite image onto a 2GB or larger SD card.  The Raspberry Pi documentation explains the proceedure:
https://www.raspberrypi.org/documentation/installation/installing-images/


# Copy Git content
This Git repository is structured like the file system on the SD card.  Copy the files in the repo to the same location on your SD card.


# Boot configuration
Be sure to copy /boot/config.txt from the Git repo to the boot partition on your SD card.  The following lines should appear at the end of the file: 
```
dtoverlay=pi3-disable-bt
gpu_mem=256
enable_uart=1
```


# Enable SSH
```
sudo raspi-config
choose interface options
enable ssh
```

# Enable serial console (optional)
Having access to a serial console can be handy for debug.  Connect a [USB serial cable](https://elinux.org/RPi_Serial_Connection) to the Raspberry Pi.

You will need to use terminal emulator software such as `screen` or `minicom` to access the serial console.

```
sudo screen /dev/ttyUSB0 115200
```


# Compile wifibroadcast
```
apt-get install libpcap-dev
cd /root/wifibroadcast
make
```

# dnsmasq DNS + DHCP server
```
sudo apt install dnsmasq
sudo systemctl start dnsmasq
```

# NginX web server
```
sudo apt install nginx
ln -s /etc/nginx/sites-available/oresat_hgs /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default
```

# Enable HostAP
```
sudo apt install hostapd
sudo systemctl unmask hostapd
sudo systemctl enable hostapd
sudo systemctl start hostapd
```

**Your ground station should now be properly configured and start automatically on the next reboot.**


# Useful Notes
## Saving a minimal-sized SD card image
[Download PiShrink](https://github.com/Drewsif/PiShrink)
```
dd bs=8M if=/dev/mmcblk0 of=~/oresat_hgs_raw.img
sudo pishrink.sh ~/oresat_hgs_raw.img ~/oresat_hgs.img
```