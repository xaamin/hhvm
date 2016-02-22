## PHP HHVM Dockerfile
This repository contains **Dockerfile** of PHP5 HHVM Docker's [automated build](https://hub.docker.com/r/xaamin/hhvm)

### Base docker image
* [xaamin/php-cli](https://registry.hub.docker.com/r/xaamin/php)

### Installation
* Install [Docker](https://www.docker.com)
* Pull from [Docker Hub](https://hub.docker.com/r/xaamin/hhvm) `docker pull xaamin/hhvm`

### Manual build
* Build an image from Dockerfile `docker build -t xaamin/hhvm https://github.com/xaamin/hhvm.git`

### Volumes
You must provide a volume mounted on /shared containing all files to serve

### Usage
```
	docker run -d -name "hhvm.server" --restart always -v /path/with/php/files:/shared xaamin/hhvm
```