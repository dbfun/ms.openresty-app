FROM openresty/openresty:buster-fat

COPY ./docker/openresty-app/conf/nginx.conf      /usr/local/openresty/nginx/conf/nginx.conf
COPY ./src/openresty-app                         /srv

HEALTHCHECK --interval=60s --timeout=5s --start-period=5s CMD /srv/docker-healthcheck.sh

EXPOSE 80