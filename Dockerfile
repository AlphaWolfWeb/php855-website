FROM php:8.5.5-apache

RUN docker-php-ext-install pdo pdo_mysql

WORKDIR /var/www/html

COPY --chown=www-data:www-data . /var/www/html

RUN chown -R www-data:www-data /var/www/html