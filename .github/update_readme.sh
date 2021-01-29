#!/bin/bash

NGINX=$(grep <package_versions.txt -E "nginx.*?-" | sed -n 1p | cut -c 7- | sed -E 's/-r.*//g')

sed -i -E \
	-e "s/nginx-.*?-269539/nginx-${NGINX}-269539/g" \
	README.md
