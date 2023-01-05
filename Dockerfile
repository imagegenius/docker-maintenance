FROM ghcr.io/imagegenius/baseimage-alpine:latest

# Set Arguments
ARG BUILD_DATE
ARG VERSION
LABEL build_version="ImageGenius Version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="hydazz"

RUN  \
	echo "**** install packages ****" && \
	apk add --no-cache \
		nginx \
		openssl && \
	echo "**** configure nginx ****" && \
	rm -f /etc/nginx/conf.d/default.conf

# add local files
COPY root/ /

# ports and volumes
EXPOSE 80 443
VOLUME /config
