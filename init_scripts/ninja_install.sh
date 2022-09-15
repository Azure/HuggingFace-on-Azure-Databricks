#!/bin/bash

wget https://github.com/ninja-build/ninja/releases/download/v1.11.0/ninja-linux.zip -P /tmp
sudo unzip /tmp/ninja-linux.zip -d /usr/local/bin/
sudo update-alternatives --install /usr/bin/ninja ninja /usr/local/bin/ninja 1 --force
