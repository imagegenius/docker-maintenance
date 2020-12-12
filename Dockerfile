FROM vcxpz/docker-baseimage-alpine:latest

# Set Arguments
LABEL build_version="Version:- 2020-12-12"
LABEL maintainer="hydaz"

RUN \
 echo "**** Update Base Image Packages ****" && \
 apk upgrade --no-cache && \
  echo "**** install build packages ****" && \
  apk add --no-cache \
 	logrotate \
 	nginx \
  nginx-mod-http-headers-more && \
  echo "**** configure nginx ****" && \
  rm -f /etc/nginx/conf.d/default.conf && \
  echo "**** fix logrotate ****" && \
  sed -i "s#/var/log/messages {}.*# #g" /etc/logrotate.conf && \
  sed -i 's#/usr/sbin/logrotate /etc/logrotate.conf#/usr/sbin/logrotate /etc/logrotate.conf -s /config/log/logrotate.status#g' \
 	/etc/periodic/daily/logrotate

 # add local files
 COPY root/ /

 # ports and volumes
 EXPOSE 80 443
 VOLUME /config
