nginx-vod-module-docker
=======================

[![Build Status](https://cloud.drone.io/api/badges/nytimes/nginx-vod-module-docker/status.svg)](https://cloud.drone.io/nytimes/nginx-vod-module-docker)

This repository contains a Dockerfile for building nginx with [Kaltura's
vod-module](https://github.com/kaltura/nginx-vod-module).

Building locally
----------------

This repository uses Docker's multi-stage builds, therefore building this image
requires Docker 17.05 or higher. Given that you have all the required
dependencies, building the image is as simple as running a ``docker build``:

```
docker build -t nytimes/nginx-vod-module .
```

Docker Hub
----------

The image is available on Docker Hub: https://hub.docker.com/r/nytimes/nginx-vod-module/.



chmod -R 755 $(pwd)/examples/videos

docker-compose up --build

OR

cd examples

docker run -p 3030:80 \
    -v $(pwd)/videos:/opt/static/videos \
    -v $(pwd)/nginx.conf:/usr/local/nginx/conf/nginx.conf \
    nytimes/nginx-vod-module

http://localhost:3030/videos/

docker run -p 3030:80 \
    -v $(pwd)/videos:/opt/static/videos \
    -v $(pwd)/nginx.conf:/usr/local/nginx/conf/nginx.conf \
    -v $(pwd)/logs:/var/log/nginx \
    --entrypoint sh nytimes/nginx-vod-module -c "mkdir -p /var/lib/nginx/body && chmod 777 /var/lib/nginx/body && exec /usr/local/nginx/sbin/nginx -g 'daemon off;'"

