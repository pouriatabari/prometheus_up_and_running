#!/bin/bash
useradd -M -r -s /bin/false node_exporter
wget https://github.com/prometheus/node_exporter/releases/download/v1.5.0/node_exporter-1.5.0.linux-amd64.tar.gz
tar -xvzf node_exporter-1.5.0.linux-amd64.tar.gz
cp node_exporter-1.5.0.linux-amd64/node_exporter /usr/local/bin/
chown node_exporter:node_exporter /usr/local/bin/node_exporter
cp /services/node_exporter.service /etc/systemd/system/node_exporter.service
systemctl daemon-reload
systemctl start node_exporter
systemctl enable node_exporter
#curl localhost:9100/metrics
firewall-cmd --add-port=9100/tcp --permanent
firewall-cmd --reload
