FROM php:7.3-apache
# install all the dependencies and enable PHP modules
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
      procps \
      nano \
      git \
      unzip \
      libicu-dev \
      zlib1g-dev \
      libxml2 \
      libxml2-dev \
      libreadline-dev \
      supervisor \
      cron \
      libzip-dev \
      libmagickwand-dev --no-install-recommends \
      libpng-dev \
      libwebp-dev \
      libjpeg62-turbo-dev \
      libpng-dev libxpm-dev \
      libfreetype6-dev \
    && docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
    && docker-php-ext-configure intl \
    && docker-php-ext-install \
      pdo_mysql \
      sockets \
      intl \
      exif \
      opcache \
      zip \
&& docker-php-ext-configure gd \
    --with-gd \
    --with-webp-dir \
    --with-jpeg-dir \
    --with-png-dir \
    --with-zlib-dir \
    --with-xpm-dir \
    --with-freetype-dir \
&& docker-php-ext-install gd \ 
&& printf "\n" | pecl install imagick \
&& docker-php-ext-enable imagick \
&& rm -rf /tmp/* \
    && rm -rf /var/list/apt/* \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean
    
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer