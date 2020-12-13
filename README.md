
Barebones NGINX server, specifically made to be a maintenance page for when your SWAG container is down. Theoretically, when you stop your SWAG container and spin this one up, it should just work. When you startup this image it will attempt to migrate from SWAG, and it works for me so whatever, you may need to change some settings in your NGINX configs in order for it to start properly

## Version Information
| Name | Version |
| :---: | --- |
| Alpine | Edge |
| Nginx | 1.18.0 |

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
  vcxpz/docker-maintenance
```
