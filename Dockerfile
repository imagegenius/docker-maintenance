FROM vcxpz/baseimage-alpine

# Set Arguments
ARG BUILD_DATE
ARG VERSION
LABEL build_version="hydaz version: ${VERSION} Build-date: ${BUILD_DATE}"
LABEL maintainer="hydaz"

RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
 	logrotate \
 	nginx && \
  echo "**** configure nginx ****" && \
  rm -f /etc/nginx/conf.d/default.conf && \
  echo "**** fix logrotate ****" && \
  sed -i "s#/var/log/messages {}.*# #g" /etc/logrotate.conf && \
  sed -i 's#/usr/sbin/logrotate /etc/logrotate.conf#/usr/sbin/logrotate /etc/logrotate.conf -s /config/log/logrotate.status#g' \
 	/etc/periodic/daily/logrotate

 # add local files
 COPY root/ /

 # check nginx configs
 HEALTHCHECK CMD nginx -t -c /config/nginx/nginx.conf || exit 1

 # ports and volumes
 EXPOSE 80 443
 VOLUME /config
