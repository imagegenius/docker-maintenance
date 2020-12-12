## docker-swag
[LSIO's SWAG](https://github.com/linuxserver/docker-swag) image running on Alpine Edge, This image also has the required dependencies for Nextcloud, so you don't have to double up on running two separate containers.
This image also been stripped Lua (Definitely not because it was causing startup errors I couldn't be bothered fixing) as I don't it them for my use case. I've changed some core folder locations such as www has become domains, in where you can make a folder for each domain.

## Custom Commands
### *Service* Command
This image also features the *service* command, which is a bash script I made so you don't have to restart the whole container to apply configuration changes and/or to test the configuration.
*service* usage example:

|Function|Usage|
|--|--|
|Test NGINX Configuration|service nginx test|
|Restart NGINX|service nginx restart|
|Restart PHP-FPM|service php restart|
|Test php.ini|service php test|

## Usage

### docker cli

```
docker run -d \
  --name=swag \
  --cap-add=NET_ADMIN \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -e URL=yourdomain.url \
  -e SUBDOMAINS=www, \
  -e VALIDATION=http \
  -e DNSPLUGIN=cloudflare `#optional` \
  -e PROPAGATION= `#optional` \
  -e DUCKDNSTOKEN= `#optional` \
  -e EMAIL= `#optional` \
  -e ONLY_SUBDOMAINS=false `#optional` \
  -e EXTRA_DOMAINS= `#optional` \
  -e STAGING=false `#optional` \
  -e MAXMINDDB_LICENSE_KEY= `#optional` \
  -p 443:443 \
  -p 80:80 \
  -v /path/to/appdata/config:/config \
  --restart unless-stopped \
  vcxpz/docker-swag-edge
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 443` | Https port |
| `-p 80` | Http port (required for http validation and http -> https redirect) |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e TZ=Europe/London` | Specify a timezone to use EG Europe/London. |
| `-e URL=yourdomain.url` | Top url you have control over (`customdomain.com` if you own it, or `customsubdomain.ddnsprovider.com` if dynamic dns). |
| `-e SUBDOMAINS=www,` | Subdomains you'd like the cert to cover (comma separated, no spaces) ie. `www,ftp,cloud`. For a wildcard cert, set this _exactly_ to `wildcard` (wildcard cert is available via `dns` and `duckdns` validation only) |
| `-e VALIDATION=http` | Certbot validation method to use, options are `http`, `dns` or `duckdns` (`dns` method also requires `DNSPLUGIN` variable set) (`duckdns` method requires `DUCKDNSTOKEN` variable set, and the `SUBDOMAINS` variable must be either empty or set to `wildcard`). |
| `-e DNSPLUGIN=cloudflare` | Required if `VALIDATION` is set to `dns`. Options are `aliyun`, `cloudflare`, `cloudxns`, `cpanel`, `digitalocean`, `dnsimple`, `dnsmadeeasy`, `domeneshop`, `gandi`, `google`, `inwx`, `linode`, `luadns`, `netcup`, `nsone`, `ovh`, `rfc2136`, `route53` and `transip`. Also need to enter the credentials into the corresponding ini (or json for some plugins) file under `/config/dns-conf`. |
| `-e PROPAGATION=` | Optionally override (in seconds) the default propagation time for the dns plugins. |
| `-e DUCKDNSTOKEN=` | Required if `VALIDATION` is set to `duckdns`. Retrieve your token from https://www.duckdns.org |
| `-e EMAIL=` | Optional e-mail address used for cert expiration notifications. |
| `-e ONLY_SUBDOMAINS=false` | If you wish to get certs only for certain subdomains, but not the main domain (main domain may be hosted on another machine and cannot be validated), set this to `true` |
| `-e EXTRA_DOMAINS=` | Additional fully qualified domain names (comma separated, no spaces) ie. `extradomain.com,subdomain.anotherdomain.org,*.anotherdomain.org` |
| `-e STAGING=false` | Set to `true` to retrieve certs in staging mode. Rate limits will be much higher, but the resulting cert will not pass the browser's security test. Only to be used for testing purposes. |
| `-e MAXMINDDB_LICENSE_KEY=` | Add your MaxmindDB license key to automatically download the GeoLite2-City.mmdb database. Download location is /config/geoip2db. The database is updated weekly. |
| `-v /config` | All the config files including the webroot reside here. |

Do not use this image unless you know what you're doing!
**This image will not work out of the box, some NGINX config files may require tweaking**
