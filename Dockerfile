FROM alpine:3.6 as build

RUN apk add --no-cache curl build-base openssl openssl-dev zlib-dev linux-headers pcre-dev ffmpeg ffmpeg-dev
RUN mkdir nginx nginx-vod-module nginx-upstream-dynamic-servers

ENV NGINX_VERSION 1.12.1
ENV VOD_MODULE_VERSION 1.18

# This is the commit that makes nginx-upstream-dynamic-servers compatible with
# nginx 1.12.1, once there's a release of the module, we can start using a
# version number.
ENV DYN_UPSTREAM_VERSION 29e05c5de4d9e7042f66b99d22bef878fd761219

RUN curl -sL https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz | tar -C nginx --strip 1 -xz
RUN curl -sL https://github.com/kaltura/nginx-vod-module/archive/${VOD_MODULE_VERSION}.tar.gz | tar -C nginx-vod-module --strip 1 -xz
RUN curl -sL https://github.com/GUI/nginx-upstream-dynamic-servers/archive/${DYN_UPSTREAM_VERSION}.tar.gz | tar -C nginx-upstream-dynamic-servers --strip 1 -xz

WORKDIR nginx
RUN ./configure --prefix=/usr/local/nginx \
	--add-module=../nginx-vod-module \
	--add-module=../nginx-upstream-dynamic-servers \
	--with-file-aio \
	--with-threads \
	--with-cc-opt="-O3"
RUN make
RUN make install

FROM alpine:3.5
RUN apk add --no-cache ca-certificates openssl pcre zlib ffmpeg
COPY --from=build /usr/local/nginx /usr/local/nginx
RUN rm -rf /usr/local/nginx/html /usr/loca/nginx/conf/*.default
ENTRYPOINT ["/usr/local/nginx/sbin/nginx"]
CMD ["-g", "daemon off;"]
