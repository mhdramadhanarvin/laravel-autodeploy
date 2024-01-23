# -----------------------------------------------------------------------------
# Build javascript dependencies
# -----------------------------------------------------------------------------
FROM node:18-slim AS builder-npm
WORKDIR /app
COPY . .
RUN rm -rf node_modules && \
  npm cache clean --force && \
  npm ci
RUN npm run build

# -----------------------------------------------------------------------------
# Build php library dependencies
# -----------------------------------------------------------------------------
FROM composer:lts AS builder-composer
WORKDIR /app
COPY . .
RUN composer install --optimize-autoloader

# -----------------------------------------------------------------------------
# Build app
# -----------------------------------------------------------------------------
FROM php:8.2-fpm-alpine
RUN docker-php-ext-install pdo pdo_mysql
WORKDIR /var/www
USER www-data:www-data
COPY --chown=www-data:www-data . .
COPY --from=builder-npm --chown=www-data:www-data /app/node_modules node_modules/
COPY --from=builder-npm --chown=www-data:www-data /app/public public/
COPY --from=builder-composer --chown=www-data:www-data /app/vendor vendor/

EXPOSE 9000
CMD ["php-fpm"]
