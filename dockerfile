from  php:8.0-apache
run apt-get update && apt-get upgrade -y
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli
run apt-get install vim -y
copy index.php /var/www/html
expose 80