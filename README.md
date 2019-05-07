# pi-scripts

The scripts in this repo are used to automate the installation of http://k3s.io on my raspberry pi cluster.

## PiBakery

### Overview

PiBakery (https://www.pibakery.org/) is used to automate the process of creating custom boot images. This allows you to create a fully automated headless setup. Just plug in your pi and log in a few minutes later!

Here is my configuration:

![PiBakery Configuration](images/pibakery-k3s-master?raw=true "PiBakery Configuration")
  
Long bash scripts do not work well in PiBakery, so it may be helpful to create a single **Run Command** to boot from GitHub:

`curl -sfL https://raw.githubusercontent.com/schottsfired/pi-scripts/master/k3s-master/bootstrap.sh | sh -`

### Logs

PiBakery logs are located at `/boot/PiBakery/firstboot.log`.

The bootstrap script logs messages to `/var/log/syslog`.

### Bugs

If your **Run Command** is not working, it may be due to the fact that the WiFi setup block didn't complete successfully or isn't ready. You can either build PiBakery from source (which does not seem to work on OSX), or modify files directly under `Macintosh HD⁩ ▸ ⁨Applications⁩ ▸ ⁨PiBakery.app⁩ ▸ ⁨Contents⁩ ▸ ⁨Resources⁩ ▸ ⁨app⁩ ▸ ⁨pibakery-blocks⁩`. 

My `/wifisetup/wifiConnect.py` was edited as follows:

```
os.system("wpa_cli -i wlan0 reconfigure")
time.sleep(5)
os.system("systemctl daemon-reload")
time.sleep(5)
os.system("systemctl restart dhcpcd")
time.sleep(5)
```


