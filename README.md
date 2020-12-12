
## docker-maintenance
Barebones NGINX server, specifically made to be a maintenance page for when your SWAG container is down. Theoretically, when you stop your SWAG container and spin this one up, it should just work. When you startup this image it will attempt to migrate from SWAG, and it works for me so whatever, you may need to change some settings in your NGINX configs in order for it to start properly

## Usage

### docker cli

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

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 443` | HTTPS port |
| `-p 80` | HTTP port (required for HTTP -> HTTPS redirect) |
| `-e PUID=1000` | for UserID |
| `-e PGID=1000` | for GroupID |
| `-v /config` | All the config files reside here. |
| `-v /swag` | This can be mounted as read-only as the container only copies files from here to its own appdata. |
