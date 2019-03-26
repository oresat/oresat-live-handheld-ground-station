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
APSSID="OreSatLiveHuGS"
APPASS="OreSatLiveHuGS"
IP_ADDRESS="192.168.4.1"

apt-get update
apt-get upgrade

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

# Save old dnsmasq configuration file and make new one
# Providing IP addresses between 192.168.4.2 and 192.168.4.20
# with lease time of 24 hrs
mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig
cat > /etc/dnsmasq.conf << EOF
interface=wlan0
    dhcp-range=192.168.4.2,192.168.4.20,255.255.255.0,24h
EOF

# Configure hostapd for access point setup
cat > /etc/hostapd/hostapd.conf << EOF
interface=wlan0
driver=nl80211
ssid=$APSSID
hw_mode=g
channel=7
wmm_enabled=0
macaddr_acl=0
auth_algs=1
ignore_broadcast_ssid=0
wpa=2
wpa_passphrase=$APPASS
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP
rsn_pairwise=CCMP
EOF

# Provide path to config file for hostapd
sed -i -- 's/#DAEMON_CONF=""/DAEMON_CONF="\/etc\/hostapd\/hostapd.conf"/g' /etc/default/hostapd
chmod +r /etc/default/hostapd # environment definition file needs read access.

# Unmask hostapd and start services that we stopped
systemctl unmask hostapd.service
systemctl start hostapd
systemctl start dnsmasq

# Add routing and masquerade
sed -i -- 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# Save ip tables rule and have them installed on boot
sh -c "iptables-save > /etc/iptables.ipv4.nat"
sed -i '/exit 0/iptables-restore < \/etc\/iiptables.ipv4.nat' /etc/rc.local

# enable hostapd to start on boot
update-rc.d hostapd enable 

echo 'AP mode Setup done. Please reboot for changes to take effect.'
echo 'After reboot, connect to wirelesss network $APSSID to connect to this AP.'
echo 'You can connect to this pi using the following IP address: $IP_ADDRESS'
