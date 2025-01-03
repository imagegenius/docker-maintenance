<!-- DO NOT EDIT THIS FILE MANUALLY -->
<!-- Please read https://github.com/imagegenius/docker-maintenance/blob/main/.github/CONTRIBUTING.md -->

# This image is deprecated. We will not offer support for this image and it will not be updated.

No longer use this image

# [imagegenius/maintenance](https://github.com/imagegenius/docker-maintenance)

[![GitHub Release](https://img.shields.io/github/release/imagegenius/docker-maintenance.svg?color=007EC6&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://github.com/imagegenius/docker-maintenance/releases)
[![GitHub Package Repository](https://shields.io/badge/GitHub%20Package-blue?logo=github&logoColor=ffffff&style=for-the-badge)](https://github.com/imagegenius/docker-maintenance/packages)
[![Jenkins Build](https://img.shields.io/jenkins/build?labelColor=555555&logoColor=ffffff&style=for-the-badge&jobUrl=https%3A%2F%2Fci.imagegenius.io%2Fjob%2FDocker-Pipeline-Builders%2Fjob%2Fdocker-maintenance%2Fjob%2Fmain%2F&logo=jenkins)](https://ci.imagegenius.io/job/Docker-Pipeline-Builders/job/docker-maintenance/job/main/)
[![IG CI](https://img.shields.io/badge/dynamic/yaml?color=007EC6&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=CI&query=CI&url=https%3A%2F%2Fci-tests.imagegenius.io%2Fmaintenance%2Flatest-main%2Fci-status.yml)](https://ci-tests.imagegenius.io/maintenance/latest-main/index.html)

Maintenance is a minimal nginx docker image with a soul purpose to be a maintenance page for when your main webserver is down

[![maintenance](https://avatars.githubusercontent.com/u/121947548?s=200&v=4)](https://imagegenius/docker-maintenance/)

## Supported Architectures

We use Docker manifest for cross-platform compatibility. More details can be found on [Docker's website](https://distribution.github.io/distribution/spec/manifest-v2-2/#manifest-list).

To obtain the appropriate image for your architecture, simply pull `ghcr.io/imagegenius/maintenance:latest`. Alternatively, you can also obtain specific architecture images by using tags.

This image supports the following architectures:

| Architecture | Available | Tag |
| :----: | :----: | ---- |
| x86-64 | ✅ | amd64-\<version tag\> |
| arm64 | ❌ | |
| armhf | ❌ | |

## Application Setup

This image probably does not work anymore, use with caution. or open an issue/pr

Barebones Nginx server made to be a maintenance page for when your SWAG container is down or backing up. Theoretically, when you stop your SWAG container and spin this one up, it should just work. When you startup this image it will attempt to migrate from SWAG, and it works for me so whatever. You may need to change some settings in your configs for Nginx to start successfully. There is also a standalone mode if you do not have SWAG.

If you have important proxy-confs, such as Home Assistant that you need to have 24/7 uptime, add proxy-confs/homeassistant.<subdomain/subfolder>.conf to /config/includes.txt and it will copy over to the maintenance appdata, and you will be able to access Home Assistant through this container. This works for any proxy config.

## Usage

Example snippets to start creating a container:

### Docker Compose

```yaml
---
services:
  maintenance:
    image: ghcr.io/imagegenius/maintenance:latest
    container_name: maintenance
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Etc/UTC
    volumes:
      - path_to_appdata:/config
      - path_to_swag:/swag
    ports:
      - 80:80
      - 443:443
    restart: unless-stopped
```

### Docker CLI ([Click here for more info](https://docs.docker.com/engine/reference/commandline/cli/))

```bash
docker run -d \
  --name=maintenance \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Etc/UTC \
  -p 80:80 \
  -p 443:443 \
  -v path_to_appdata:/config \
  -v path_to_swag:/swag \
  --restart unless-stopped \
  ghcr.io/imagegenius/maintenance:latest
```

## Parameters

To configure the container, pass variables at runtime using the format `<external>:<internal>`. For instance, `-p 8080:80` exposes port `80` inside the container, making it accessible outside the container via the host's IP on port `8080`.

| Parameter | Function |
| :----: | --- |
| `-p 80` | HTTP Port |
| `-p 443` | HTTPS Port |
| `-e PUID=1000` | UID for permissions - see below for explanation |
| `-e PGID=1000` | GID for permissions - see below for explanation |
| `-e TZ=Etc/UTC` | Specify a timezone to use, see this [list](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List). |
| `-v /config` | Contains configuration files |
| `-v /swag` | Location of swag appdata on the host |

## Umask for running applications

All of our images allow overriding the default umask setting for services started within the containers using the optional -e UMASK=022 option. Note that umask works differently than chmod and subtracts permissions based on its value, not adding. For more information, please refer to the Wikipedia article on umask [here](https://en.wikipedia.org/wiki/Umask).

## User / Group Identifiers

To avoid permissions issues when using volumes (`-v` flags) between the host OS and the container, you can specify the user (`PUID`) and group (`PGID`). Make sure that the volume directories on the host are owned by the same user you specify, and the issues will disappear.

Example: `PUID=1000` and `PGID=1000`. To find your PUID and PGID, run `id user`.

```bash
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```


## Updating the Container

Most of our images are static, versioned, and require an image update and container recreation to update the app. We do not recommend or support updating apps inside the container. Check the [Application Setup](#application-setup) section for recommendations for the specific image.

Instructions for updating containers:

### Via Docker Compose

* Update all images: `docker-compose pull`
  * or update a single image: `docker-compose pull maintenance`
* Let compose update all containers as necessary: `docker-compose up -d`
  * or update a single container: `docker-compose up -d maintenance`
* You can also remove the old dangling images: `docker image prune`

### Via Docker Run

* Update the image: `docker pull ghcr.io/imagegenius/maintenance:latest`
* Stop the running container: `docker stop maintenance`
* Delete the container: `docker rm maintenance`
* Recreate a new container with the same docker run parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* You can also remove the old dangling images: `docker image prune`

## Versions

* **24.04.24:** - rebase to alpine 3.19
* **02.01.23:** - Initial Release.
