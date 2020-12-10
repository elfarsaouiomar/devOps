FROM php:7.2.2-fpm

LABEL maintainer "@omarelfarsaoui"

RUN apt-get update -y && apt-get install -y libmcrypt-dev openssl
RUN docker-php-ext-install pdo pdo_mysql

WORKDIR /var/www/html/laravelapp
COPY . /var/www/html/laravelapp
RUN chown -R www-data:www-data /var/www/html/laravelapp/
USER www-data