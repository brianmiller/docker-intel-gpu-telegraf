FROM fedora:latest

LABEL maintainer=brian@phospher.com

WORKDIR ./opt/intel-gpu-telegraf

RUN \
 echo "[influxdb]" > /etc/yum.repos.d/influxdb.repo && \
 echo "name=InfluxDB Repository - RHEL" >> /etc/yum.repos.d/influxdb.repo && \
 echo "baseurl=https://repos.influxdata.com/rhel/7/x86_64/stable/" >> /etc/yum.repos.d/influxdb.repo && \
 echo "enabled=1" >> /etc/yum.repos.d/influxdb.repo && \
 echo "gpgcheck=1" >> /etc/yum.repos.d/influxdb.repo && \
 echo "gpgkey=https://repos.influxdata.com/influxdb.key" >> /etc/yum.repos.d/influxdb.repo

RUN dnf install -y igt-gpu-tools telegraf iputils net-tools vim-enhanced
RUN rm -rf /var/cache/*

COPY ./opt/intel-gpu-telegraf /opt/intel-gpu-telegraf

VOLUME /config

CMD ["/usr/bin/telegraf", "--config", "/opt/intel-gpu-telegraf/telegraf.conf"]
