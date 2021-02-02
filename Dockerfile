ARG TAG
FROM vcxpz/baseimage-alpine:${TAG}

# Set Arguments
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="hydaz"

RUN \
	echo "**** install runtime packages ****" && \
	apk add --no-cache --upgrade \
		nginx \
		openssl && \
	echo "**** configure nginx ****" && \
	rm -f /etc/nginx/conf.d/default.conf

# add local files
COPY root/ /

# http healthcheck
HEALTHCHECK --start-period=10s --timeout=5s \
	CMD wget -qO /dev/null 'http://localhost' || exit 1

# ports and volumes
EXPOSE 80 443
VOLUME /config
