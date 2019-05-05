# pi-scripts

The scripts in this repo are used to automate the installation of http://k3s.io on my raspberry pi cluster.

## PiBakery

PiBakery (https://www.pibakery.org/) is used to automate the process of creating custom boot images.

(Insert PiBakery screenshot here)
  
A single **Run Command** block in PiBakery can be used to automate the installation from GitHub:

`curl -sfL https://raw.githubusercontent.com/schottsfired/pi-scripts/master/k3s-master/bootstrap.sh | sh -`
