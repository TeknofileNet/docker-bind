FROM wtfo/docker-base-ubuntu-s6
LABEL maintainer="teknofile <teknofile@teknofile.org>"
RUN apt-get update

# TODO: add a seperate file into /etc/apt/sources.list.d
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y gnupg && \
  apt-key adv --fetch-keys http://www.webmin.com/jcameron-key.asc && \
  echo "deb http://download.webmin.com/download/repository sarge contrib" >> /etc/apt/sources.list


ENV BIND_USER=bind \
    BIND_VERSION=9.11.3 \
    WEBMIN_VERSION=1.9 \
    DNSUTILS_VERSION=9.11.3+dfsg-1ubuntu1.11 \
    DATA_DIR=/data 

RUN rm -rf /etc/apt/apt.conf.d/docker-gzip-indexes
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y && \
  bind9=1:${BIND_VERSION}* \
  dnsutils=1:${DNSUTILS_VERSION} && \
  webmin=${WEBMIN_VERSION}* && \
  rm -rf /var/lib/apt/lists/*

#COPY entrypoint.sh /sbin/entrypoint.sh
#
#RUN chmod 755 /sbin/entrypoint.sh
#
EXPOSE 53/udp 53/tcp 10000/tcp
#
#ENTRYPOINT ["/sbin/entrypoint.sh"]
#
#CMD ["/usr/sbin/named"]
