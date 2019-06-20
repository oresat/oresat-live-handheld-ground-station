#!/bin/bash
# AP mode setup instruction source:
# https://www.raspberrypi.org/documentation/configuration/wireless/access-point.md
#
# As noted in "/usr/share/doc/hostapd/NEWS.Debian.gz", hostapd.service is to be
# unmasked after first install and after package upgrades
# 
# Tested on Raspbian GNU/Linux 9 (stretch)
# Last Updated: 2019-3-26

if [ "$EUID" -ne 0 ]
then echo "This script must be run in root to setup AP mode."
    exit
fi

# Variables for setting up AP mode and static IP.
IP_ADDRESS="192.168.4.1"

apt-get update

apt-get install dnsmasq hostapd

printf "\n\nUpdates done. Moving onto AP mode setup..."
# Turn services off while we set up configuration files 
systemctl stop dnsmasq
systemctl stop hostapd

# Configure static IP address
cat > /etc/dhcpcd.conf << EOF
interface=wlan0
    static ip_address=${IP_ADDRESS}/24 
    nohook wpa_supplicant
EOF

# Restart dhcpcd to set up new wlan0 configuration
service dhcpcd restart

# configure DHCP and DNS services
cat > /etc/dnsmasq.conf << EOF
interface=wlan0
address=/#/192.168.4.1
dhcp-range=192.168.4.2,192.168.4.250,255.255.255.0,1h
dhcp-option=3,192.168.4.1
dhcp-option=6,192.168.4.1
dhcp-authoritative
domain=localnet
#log-queries
EOF

# Configure hostapd for access point setup
cat > /etc/hostapd/hostapd.conf << EOF
interface=wlan0
driver=nl80211
ssid=OreSatLive
hw_mode=g
channel=9
EOF

# Provide path to config file for hostapd
sed -i -- 's/#DAEMON_CONF=""/DAEMON_CONF="\/etc\/hostapd\/hostapd.conf"/g' /etc/default/hostapd
chmod +r /etc/default/hostapd # environment definition file needs read access.

# Unmask hostapd and start services that we stopped
systemctl unmask hostapd.service
systemctl start hostapd
systemctl start dnsmasq

# enable hostapd to start on boot
update-rc.d hostapd enable 

echo 'AP mode Setup done. Please reboot for changes to take effect.'
echo 'After reboot, connect to wirelesss network $APSSID to connect to this AP.'
echo 'You can connect to this pi using the following IP address: $IP_ADDRESS'
