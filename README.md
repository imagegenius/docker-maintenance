## docker-maintenance

[![docker hub](https://img.shields.io/badge/docker_hub-link-blue?style=for-the-badge&logo=docker)](https://hub.docker.com/r/vcxpz/maintenance) ![docker image size](https://img.shields.io/docker/image-size/vcxpz/maintenance?style=for-the-badge&logo=docker) [![auto build](https://img.shields.io/badge/docker_builds-automated-blue?style=for-the-badge&logo=docker?color=d1aa67)](https://github.com/hydazz/docker-maintenance/actions?query=workflow%3A"Auto+Builder+CI") [![template](https://img.shields.io/badge/view_html_template-blue?style=for-the-badge)](https://htmlpreview.github.io/?https://github.com/hydazz/docker-maintenance/blob/main/root/defaults/index.html) [![codacy branch grade](https://img.shields.io/codacy/grade/a950a2aa31fa453a92272f389df5bf03/main?style=for-the-badge&logo=codacy)](https://app.codacy.com/gh/hydazz/docker-maintenance)

Barebones Nginx server made to be a maintenance page for when your SWAG container is down or backing up. Theoretically, when you stop your SWAG container and spin this one up, it should just work. When you startup this image it will attempt to migrate from SWAG, and it works for me so whatever. You may need to change some settings in your configs for Nginx to start successfully. There is also a standalone mode if you do not have SWAG.

If you have important proxy-confs, such as Home Assistant that you need to have 24/7 uptime, add `proxy-confs/homeassistant.<subdomain/subfolder>.conf` to /config/includes.txt and it will copy over to the maintenance appdata, and you will be able to access Home Assistant through this container. This works for any proxy config.

## Usage

```bash
docker run -d \
  --name=maintenance \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Australia/Melbourne \
  -p 443:443 \
  -p 80:80 \
  -v <path to appdata>:/config \
  -v <path to swag data>:/swag \
  --restart unless-stopped \
  vcxpz/maintenance
```

[![template](https://img.shields.io/badge/unraid_template-ff8c2f?style=for-the-badge&logo=docker?color=d1aa67)](https://github.com/hydazz/docker-templates/blob/main/hydaz/maintenance.xml)

## Fixing Appdata Permissions

If you ever accidentally screw up the permissions on the appdata folder, run `fix-perms` within the container. This will restore most of the files/folders with the correct permissions.
