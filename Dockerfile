FROM php:fpm-alpine

RUN apk --no-cache update && apk --no-cache add postgresql-dev libzip-dev tzdata

RUN cp /usr/share/zoneinfo/Japan /etc/localtime

RUN docker-php-ext-install pdo_pgsql bcmath zip 

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"

RUN php -r "if (hash_file('sha384', 'composer-setup.php') === '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"

RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer

RUN php -r "unlink('composer-setup.php');"

RUN composer global require laravel/installer

ENV PATH $PATH:/root/.composer/vendor/bin

WORKDIR /var/www
