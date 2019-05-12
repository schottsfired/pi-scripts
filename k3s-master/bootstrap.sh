#!/bin/sh
set -e

logger Updating packages and upgrading OS...
apt-get update
apt-get --fix-broken --assume-yes upgrade

logger Enabling cgroups...
sed -i 's/rootwait/cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory rootwait/g' /boot/cmdline.txt

logger Setting Static IP to 10.0.1.100 and Routher IP to 10.0.1.1...
cat <<EOT >> /etc/dhcpcd.conf
interface wlan0
static ip_address=10.0.1.100/24
static routers=10.0.1.1
static domain_name_servers=10.0.1.1
EOT

logger Installing k3s...
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--no-deploy=servicelb" sh -
echo 'alias k="k3s kubectl"' >> ~/.bash_profile

logger Install MetalLB...
kubectl apply -f https://raw.githubusercontent.com/schottsfired/pi-scripts/master/manifests/metallb.yaml

logger Install ConfigMap for MetalLB...
kubectl apply -f https://raw.githubusercontent.com/schottsfired/pi-scripts/master/manifests/metallb-layer2-config.yaml

logger Install a simple Service
kubectl apply -f https://raw.githubusercontent.com/schottsfired/pi-scripts/master/manifests/trivial-service.yaml
