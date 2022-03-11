#!/bin/bash
if [ ! -e monitoring-installer.sh ]
then
  wget -nd -m https://raw.githubusercontent.com/ava-labs/avalanche-docs/master/scripts/monitoring-installer.sh
  chmod 755 monitoring-installer.sh
fi

./monitoring-installer.sh --1
# sudo systemctl status prometheus
# verify at http://your-node-host-ip:9090

./monitoring-installer.sh --2
# sudo systemctl status grafana-server
# verify at http://your-node-host-ip:3000

./monitoring-installer.sh --3
# this installs node-exporter for monitoring of the machine itself
# verify at http://your-node-host-ip:9090/targets 
# sudo systemctl status node_exporter

./monitoring-installer.sh --4
# this install dashboard: http://your-node-host-ip:3000/dashboards
