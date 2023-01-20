#!/bin/bash
useradd -M -r -s /bin/false prometheus
mkdir /etc/prometheus /var/lib/prometheus
wget https://github.com/prometheus/prometheus/releases/download/v2.41.0/prometheus-2.41.0.linux-amd64.tar.gz
tar xzf prometheus-2.41.0.linux-amd64.tar.gz
cp prometheus-2.41.0.linux-amd64/{prometheus,promtool} /usr/local/bin/
cp -var prometheus-2.41.0.linux-amd64/{consoles,console_libraries} /etc/prometheus/
cp prometheus-2.41.0.linux-amd64/prometheus.yml /etc/prometheus/prometheus.yml.ORG
cp prometheus-2.41.0.linux-amd64/prometheus.yml /etc/prometheus/prometheus.yml
chown -R prometheus:prometheus /etc/prometheus/
chown prometheus:prometheus /var/lib/prometheus/
prometheus --config.file=/etc/prometheus/prometheus.yml
cp /services/prometheus.service /etc/systemd/prometheus.service
systemctl daemon-reload
systemctl start prometheus
systemctl enable prometheus
#curl localhost:9090/api/v1/status/config
netstat -ntlp | grep 9090
firewall-cmd  --add-port=9090/tcp --permanent
firewall-cmd --reload
ntpdate ir.pool.ntp.org
