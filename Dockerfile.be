# Base Image
FROM php:8.2-fpm-alpine

WORKDIR /var/www/html

COPY ./Backend /var/www/html

## 
RUN chown -R www-data:www-data /var/www/html/storage

## update packages
RUN apk update

## install curl
RUN apk add curl

## install pdo mysql
RUN docker-php-ext-install mysqli pdo pdo_mysql

## install composer
RUN curl -sS https://getcomposer.org/installer | php

## move file to /usr/bin/composer
RUN mv composer.phar /usr/bin/composer

## install packages
RUN composer install --optimize-autoloader --no-dev

## use 8000 port
EXPOSE 9000

### run php-fpm
CMD ["php-fpm"]




