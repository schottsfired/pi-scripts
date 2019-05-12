#!/bin/sh
set -e

echo Updating packages and upgrading OS...
apt-get update
apt-get --fix-broken --assume-yes upgrade

echo Enabling cgroups...
sed -i 's/rootwait/cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory rootwait/g' /boot/cmdline.txt

echo Setting Static IP to 10.0.1.100 and Routher IP to 10.0.1.1...
cat <<EOT >> /etc/dhcpcd.conf
interface wlan0
static ip_address=10.0.1.100/24
static routers=10.0.1.1
static domain_name_servers=10.0.1.1
EOT

echo Installing k3s...
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--no-deploy=servicelb" sh -
echo 'alias k="k3s kubectl"' >> ~/.bash_profile

echo Waiting for kubectl to be ready...
until kubectl
do
    echo kubectl not ready...
    sleep 1
done

echo Install MetalLB...
kubectl apply -f https://raw.githubusercontent.com/schottsfired/pi-scripts/master/manifests/metallb.yaml

sleep 30

echo Install ConfigMap for MetalLB...
kubectl apply -f https://raw.githubusercontent.com/schottsfired/pi-scripts/master/manifests/metallb-layer2-config.yaml

sleep 30

echo Install a simple Service
kubectl apply -f https://raw.githubusercontent.com/schottsfired/pi-scripts/master/manifests/trivial-service.yaml
