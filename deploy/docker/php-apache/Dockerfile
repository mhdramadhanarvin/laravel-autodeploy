# -----------------------------------------------------------------------------
# Build javascript dependencies
# -----------------------------------------------------------------------------
FROM node:18-slim AS builder-npm
WORKDIR /app
COPY . .
RUN rm -rf node_modules && \
  npm cache clean --force && \
  npm install
RUN npm run build

# -----------------------------------------------------------------------------
# Build php library dependencies
# -----------------------------------------------------------------------------
COPY --from=composer /usr/bin/composer /usr/bin/composer
FROM composer AS builder-composer
WORKDIR /app
COPY . .
RUN composer install

# -----------------------------------------------------------------------------
# Build app
# -----------------------------------------------------------------------------
FROM php:8.2-apache

RUN a2enmod rewrite

RUN docker-php-ext-install pdo pdo_mysql

# RUN mv $PHP_INI_DIR/php.ini-development $PHP_INI_DIR/php.ini

COPY ./deploy/docker/php-apache/apache.conf /etc/apache2/sites-enabled/000-default.conf

WORKDIR /app
USER www-data

COPY --chown=www-data:www-data . .
COPY --from=builder-npm --chown=www-data:www-data /app/node_modules node_modules/
COPY --from=builder-npm --chown=www-data:www-data /app/public/build public/build/
COPY --from=builder-composer --chown=www-data:www-data /app/vendor vendor/

# RUN chown -R www-data:www-data storage
# RUN chown -R www-data:www-data bootstrap/cache

RUN chmod -R 775 /app/storage
RUN chmod -R 775 /app/bootstrap/cache

EXPOSE 80
