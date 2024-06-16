#!/bin/bash

# Update the system
sudo apt-get update
sudo apt-get upgrade -y

# Install dependencies
sudo apt-get install git python3-virtualenv libssl-dev libffi-dev build-essential -y

# Clone the Cowrie repository
git clone https://github.com/cowrie/cowrie
cd cowrie

# Set up the virtual environment
virtualenv --python=python3 cowrie-env
source cowrie-env/bin/activate

# Install Python dependencies
pip install --upgrade pip
pip install -r requirements.txt

# Configure Cowrie
cp etc/cowrie.cfg.dist etc/cowrie.cfg
sed -i 's/hostname = svr04/hostname = honeypot-server/' etc/cowrie.cfg
sed -i 's/listen_port = 2222/listen_port = 2222/' etc/cowrie.cfg
sed -i 's/listen_port = 2223/listen_port = 2223/' etc/cowrie.cfg
sed -i 's/enabled = false/enabled = true/' etc/cowrie.cfg
sed -i 's/logfile = log\/cowrie.log/logfile = log\/cowrie.log/' etc/cowrie.cfg
sed -i 's/logfile = log\/cowrie.json/logfile = log\/cowrie.json/' etc/cowrie.cfg

echo "Setup is complete. You can start Cowrie with: bin/cowrie start"
