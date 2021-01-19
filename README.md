# pi-scripts

The scripts in this repo are used to automate the installation of http://k3s.io on my raspberry pi cluster.

## PiBakery

### Overview

PiBakery (https://github.com/davidferguson/pibakery/releases) is used to automate the process of creating custom boot images. This allows you to create a fully automated headless setup. Just plug in your pi and log in a few minutes later!

Sample configuration:

![PiBakery Configuration](images/pibakery-k3s-master.png?raw=true "PiBakery Configuration")
  
It is useful to create a single **Run Command** to boot from GitHub:

`curl -sfL https://raw.githubusercontent.com/schottsfired/pi-scripts/master/k3s-master/bootstrap.sh | sh -`

### Logs

PiBakery logs are located at `/boot/PiBakery/firstboot.log`.

### SSH

SSH is disabled by default in newer versions of Raspbian. To enable it, open your Raspian `.img` file and create an `ssh` file at the root of the disk image. This can be done by running e.g. `cd /Volumes/boot && touch ssh`.

**NOTE:** SSH works as expected in older versions of PiBakery - the ones that include the Raspbian image. PiBakery 2.0+ allows you to bring your own Raspbian image, which is modified as previously described for SSH access.

### WiFi Setup

If your **Run Command** isn't working, it may be due to the fact that the WiFi setup block didn't complete successfully or isn't ready. You can modify scripts directly under `Macintosh HD⁩ ▸ ⁨Applications⁩ ▸ ⁨PiBakery.app⁩ ▸ ⁨Contents⁩ ▸ ⁨Resources⁩ ▸ ⁨app⁩ ▸ ⁨pibakery-blocks⁩`.

My `/wifisetup/wifiConnect.py` was modified as follows:

```
os.system("wpa_cli -i wlan0 reconfigure")
time.sleep(5)
os.system("systemctl daemon-reload")
time.sleep(5)
os.system("systemctl restart dhcpcd")
time.sleep(5)
```


