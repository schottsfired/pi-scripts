#!/bin/sh
set -e

echo Updating packages and upgrading OS...
apt-get update
apt-get --fix-broken --fix-missing --assume-yes upgrade

echo Enabling cgroups...
sed -i 's/rootwait/cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory rootwait/g' /boot/cmdline.txt

echo Setting Static IP to 10.0.1.101 and Routher IP to 10.0.1.1...
cat <<EOT >> /etc/dhcpcd.conf
interface wlan0
static ip_address=10.0.1.101/24
static routers=10.0.1.1
static domain_name_servers=10.0.1.1
EOT

echo Fix touch screen mouse tracking issue...
apt-get install xserver-xorg-input-evdev
cp -rf /usr/share/X11/xorg.conf.d/10-evdev.conf /usr/share/X11/xorg.conf.d/45-evdev.conf

echo Install 3.5 inch LCD touch screen (script triggers restart)...
git clone https://github.com/goodtft/LCD-show /home/pi/LCD-show
cd /home/pi && source /home/pi/LCD-show/LCD35-show

#NODE_TOKEN comes from /var/lib/rancher/k3s/server/node-token on the master
#sudo curl -sfL https://get.k3s.io | K3S_TOKEN=xxx K3S_URL=https://10.0.1.100:6443 sh -
