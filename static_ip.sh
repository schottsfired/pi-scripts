cat <<EOT >> /etc/dhcpcd.conf
interface wlan0
static ip_address=10.0.1.100/24
static routers=10.1.1.1
static domain_name_servers=10.1.1.1
EOT
