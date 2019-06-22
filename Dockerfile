FROM php:7.2.14-apache

# install libraries
RUN apt-get update && apt-get install -y git g++ \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libxml2-dev \
        libbz2-dev \
        libgeoip-dev \
        zlib1g-dev \
        libxslt-dev \
        libicu-dev \
        libmemcached-dev \
        cron \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) intl xml bcmath zip soap mbstring json bcmath pdo_mysql gd opcache xsl \
    && rm /etc/localtime && \
        ln -s /usr/share/zoneinfo/Asia/Bangkok /etc/localtime && \
        a2enmod rewrite ssl headers

RUN  usermod -s /bin/bash www-data

# Copy Code
COPY --chown=www-data:www-data /app /app/

# Config Vhost
COPY conf/*  /etc/apache2/sites-available
