# syntax=docker/dockerfile:1

FROM ghcr.io/imagegenius/baseimage-alpine:3.18

# Set Arguments
ARG BUILD_DATE
ARG VERSION
ARG NGINX_VERSION
LABEL build_version="ImageGenius Version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="hydazz"

RUN \
  if [ -z ${NGINX_VERSION+x} ]; then \
    NGINX_VERSION=$(curl -sL "http://dl-cdn.alpinelinux.org/alpine/v3.17/main/x86_64/APKINDEX.tar.gz" | tar -xz -C /tmp \
      && awk '/^P:nginx$/,/V:/' /tmp/APKINDEX | sed -n 2p | sed 's/^V://'); \
  fi && \
  echo "**** install packages ****" && \
  apk add --no-cache \
    nginx==${NGINX_VERSION} \
    openssl && \
  echo "**** configure nginx ****" && \
  rm -f /etc/nginx/conf.d/default.conf

# add local files
COPY root/ /

# ports and volumes
EXPOSE 80 443
VOLUME /config
