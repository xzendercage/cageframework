#!/bin/bash
# Script for update CAGE tools

git clone --depth=1 https://github.com/xzendercage/cageframework.git
sudo chmod +x cageframework/install.sh
bash cageframework/install.sh
