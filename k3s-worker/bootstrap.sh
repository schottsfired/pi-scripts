#!/bin/sh
set -e

echo Updating packages and upgrading OS...
apt-get update
apt-get --fix-broken --assume-yes upgrade

echo Enabling cgroups...
sed -i 's/rootwait/cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory rootwait/g' /boot/cmdline.txt

echo Setting Static IP to 10.0.1.101 and Routher IP to 10.0.1.1...
cat <<EOT >> /etc/dhcpcd.conf
interface wlan0
static ip_address=10.0.1.101/24
static routers=10.0.1.1
static domain_name_servers=10.0.1.1
EOT