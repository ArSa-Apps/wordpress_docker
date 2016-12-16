# Wordpress 4.7 in Docker

This is only the wordpress. Simply build it like:
```
 $ docker build --tag=wordpress:4.7 --force-rm --no-cache .
```

In order to make it work properly, you need [Webserver](https://github.com/subugoe/nginx_docker), [PHP](https://github.com/subugoe/php-fpm_docker) and a [Database](https://hub.docker.com/_/mariadb/). This version of `docker-compose.yml` looks for specific version of those systems installed. Though Database is optional and can be used externally. Afterwards you can use `docker-compose` to make the bundle work together:
```
 $ docker-compose up -d
```

