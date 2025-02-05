FROM ubuntu:latest
MAINTAINER febriyandi
RUN apt install httpd
COPY index.html /var/www/html/
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
EXPOSE 80
