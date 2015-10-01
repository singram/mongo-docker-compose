FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN apt-get update
RUN apt-get install -y curl
RUN apt-get install -y supervisor

RUN cd /tmp \
	&& curl -OL https://downloads.mongodb.com/on-prem-mms/deb/mongodb-mms_1.6.0.231-1_x86_64.deb \
	&& curl -OL https://downloads.mongodb.com/on-prem-mms/deb/mongodb-mms-backup-daemon_1.6.0.231-1_x86_64.deb \
	&& dpkg -i mongodb-mms_1.6.0.231-1_x86_64.deb \
	&& dpkg -i mongodb-mms-backup-daemon_1.6.0.231-1_x86_64.deb

COPY config/conf-mms.properties /opt/mongodb/mms/conf/conf-mms.properties
COPY config/conf-deamon.properties /opt/mongodb/mms-backup-daemon/conf/conf-daemon.properties
COPY config/supervisord.conf /etc/supervisor/conf.d/ops-manager.conf

COPY startup.sh /tmp/startup.sh
RUN chmod +x /tmp/startup.sh

ENTRYPOINT [ "/tmp/startup.sh" ]
