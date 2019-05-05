#!/bin/sh
set -e

#enable cgroups
logger Enabling cgroups...
sudo sed -i 's/rootwait/cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory rootwait/g' /boot/cmdline.txt

#static IP address
logger Setting Static IP to 10.0.1.100 and Routher IP to 10.0.1.1...
sudo cat <<EOT >> /etc/dhcpcd.conf
interface wlan0
static ip_address=10.0.1.100/24
static routers=10.0.1.1
static domain_name_servers=10.0.1.1
EOT

#install k3s
sudo curl -sfL https://get.k3s.io | sh -
