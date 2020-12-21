## Tiny Maintenance Webserver
Barebones Nginx server specifically made to be a maintenance page for when your SWAG container is down, or backing up. Theoretically, when you stop your SWAG container and spin this one up, it should just work. When you startup this image it will attempt to migrate (create symlinks) from SWAG, and it works for me so whatever. You may need to change some settings in your configs for Nginx to start successfully.

[![Docker hub](https://img.shields.io/badge/docker%20hub-link-blue?style=for-the-badge&logo=docker)](https://hub.docker.com/repository/docker/vcxpz/maintenance) ![Docker Image Size](https://img.shields.io/docker/image-size/vcxpz/maintenance?style=for-the-badge&logo=docker) [![Autobuild](https://img.shields.io/badge/auto%20build-weekly-blue?style=for-the-badge&logo=docker?color=d1aa67)](https://github.com/hydazz/docker-maintenance/actions?query=workflow%3A%22Docker+Update+CI%22)

## Version Information
![alpine](https://img.shields.io/badge/alpine-edge-0D597F?style=for-the-badge&logo=alpine-linux) ![s6overlay](https://img.shields.io/badge/s6--overlay-2.1.0.2-blue?style=for-the-badge) ![nginx](https://img.shields.io/badge/nginx-1.18.0-269539?style=for-the-badge&logo=nginx) [![moredetail](https://img.shields.io/badge/more-detail-blue?style=for-the-badge)](https://github.com/hydazz/docker-maintenance/blob/main/package_versions.txt)

## Usage
```
docker run -d \
  --name=maintenance \
  --cap-add=NET_ADMIN \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Australia/Melbourne \
  -p 443:443 \
  -p 80:80 \
  -v <path to appdata>:/config \
  -v <path to swag data/>:/swag \
  --restart unless-stopped \
  vcxpz/maintenance
```

## Todo
* Nothing, everything works 🙂
