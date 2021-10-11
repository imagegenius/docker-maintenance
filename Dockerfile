FROM vcxpz/baseimage-alpine:latest

# Set Arguments
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="hydaz"

RUN set -xe && \
	echo "**** install runtime packages ****" && \
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
