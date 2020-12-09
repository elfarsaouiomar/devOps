FROM php:7.4.13-zts-alpine3.12

LABEL maintainer "@omarelfarsaoui"

RUN apt-get update -y && apt-get install -y libmcrypt-dev openssl
RUN docker-php-ext-install pdo pdo_mysql

WORKDIR /var/www/html/laravelapp
COPY . /var/www/html/laravelapp
RUN chown -R www-data:www-data /var/www/html/laravelapp/
USER www-data