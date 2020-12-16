## Tiny Maintenance Webserver
Barebones Nginx server (~25mb) specifically made to be a maintenance page for when your SWAG container is down, or backing up. Theoretically, when you stop your SWAG container and spin this one up, it should just work. When you startup this image it will attempt to migrate (create symlinks) from SWAG, and it works for me so whatever. You may need to change some settings in your configs for Nginx to start successfully.

## Version Information
| Name | Version |
| :---: | --- |
| Alpine | Edge |
| Nginx | 1.18.0 |
| s6-overlay | 2.1.0.2 |

*See *package_versions.txt* for more detail

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
  -v /path/to/appdata/:/config \
  -v /path/to/swag/:/swag \
  --restart unless-stopped \
  vcxpz/maintenance
```
