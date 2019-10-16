#!/bin/bash
# Startup initialization script for the official TON node

echo "==> Download systemd unit file"
wget -qO /etc/systemd/system/ton.service \
  https://raw.githubusercontent.com/awesome-nodes/ton/master/ubuntu-18.04/ton.service

echo "==> Start TON service"
systemctl daemon-reload
systemctl enable ton.service
systemctl start ton.service

echo "==> Download logrotate config file"
wget -qO /etc/logrotate.d/ton \
  https://raw.githubusercontent.com/awesome-nodes/ton/master/ubuntu-18.04/ton

echo "==> Update logrotate config file"
logrotate -f /etc/logrotate.d/ton
