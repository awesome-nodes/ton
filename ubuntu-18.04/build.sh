#!/bin/bash
# Build script for the official TON node

export INSTALL_DIR=/usr/local/bin/
export DEBIAN_FRONTEND=noninteractive

echo "==> Update system packages"
apt-get -y update
apt-get -y dist-upgrade

echo "==> Strict bash processing"
set -euo pipefail

echo "==> Install your favorite packages"
apt-get -y install mc wget htop iftop iotop

echo "==> Install required packages"
apt-get -y install build-essential cmake gperf ccache git jq
apt-get -y install libz-dev libssl-dev libmicrohttpd-dev
apt-get -y install libreadline-dev libgflags-dev

echo "==> Copy and initialise repository"
git clone https://github.com/ton-blockchain/ton.git
cd ton
git submodule update --init --recursive
mkdir build && cd build

echo "==> Prepare bulding"
cmake -DCMAKE_BUILD_TYPE=Release ..

echo "==> Build software"
#cmake --build .
make -j 4 

echo "==> Copy binaries"
cp /root/ton/build/validator-engine/validator-engine ${INSTALL_DIR}
cp /root/ton/build/validator-engine-console/validator-engine-console ${INSTALL_DIR}
cp /root/ton/build/utils/generate-random-id ${INSTALL_DIR}

echo "==> Create data directories"
[ ! -d "/var/ton-work/db" ] && mkdir -p "/var/ton-work/db"
[ ! -d "/var/ton-work/etc" ] && mkdir "/var/ton-work/etc"
[ ! -d "/var/ton-work/log" ] && mkdir "/var/ton-work/log"
