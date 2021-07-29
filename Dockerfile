#
# Dockerfile for Apache Web Server
#
FROM ubuntu:18.04
MAINTAINER Serhii Rudim <rudimsergey@gmail.com>

RUN apt-get update && \
    apt-get install -y apache2 && \
    groupadd -r hillel_devops && \
    useradd -r -s /bin/bash -m -g hillel_devops hillel_devops && \
    /usr/sbin/a2dissite 000-default.conf && \
    ln -s /etc/apache2/sites-available/virtualhost.conf /etc/apache2/sites-enabled/virtualhost.conf

COPY apacheports.conf /etc/apache2/
COPY virtualhost.conf /etc/apache2/sites-available/

WORKDIR /var/www/html/

COPY --chown=www-data:www-data index.html .

EXPOSE 8080/tcp

CMD ["apache2ctl", "-D", "FOREGROUND"]