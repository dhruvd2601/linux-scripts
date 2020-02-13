#!/bin/bash
yum install java-1.8.0-openjdk -y
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
echo '[elasticsearch-7.x]'                                       >> /etc/yum.repos.d/elasticsearch.repo
echo 'name=Elasticsearch repository for 7.x packages'            >> /etc/yum.repos.d/elasticsearch.repo
echo 'baseurl=https://artifacts.elastic.co/packages/7.x/yum'     >> /etc/yum.repos.d/elasticsearch.repo
echo 'gpgcheck=1'                                                >> /etc/yum.repos.d/elasticsearch.repo
echo 'gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch' >> /etc/yum.repos.d/elasticsearch.repo
echo 'enabled=1'                                                 >> /etc/yum.repos.d/elasticsearch.repo
echo 'autorefresh=1'                                             >> /etc/yum.repos.d/elasticsearch.repo
echo 'type=rpm-md'                                               >> /etc/yum.repos.d/elasticsearch.repo
yum install elasticsearch -y
echo 'network.host: "127.0.0.1"' >> /etc/elasticsearch/elasticsearch.yml
systemctl start elasticsearch
systemctl status elasticsearch
systemctl enable elasticsearch
curl -X GET "localhost:9200"
yum install kibana -y
mkdir -p /var/log/kibana
touch /var/log/kibana/kibana.log
chown kibana:kibana /var/log/kibana/kibana.log
echo 'server.port: 5601'                            >> /etc/kibana/kibana.yml
echo 'server.host: "0.0.0.0"'                       >> /etc/kibana/kibana.yml
echo 'elasticsearch.hosts: "http://localhost:9200"' >> /etc/kibana/kibana.yml
echo 'logging.dest: /var/log/kibana/kibana.log'     >> /etc/kibana/kibana.yml

systemctl enable kibana
systemctl start kibana
systemctl status kibana
