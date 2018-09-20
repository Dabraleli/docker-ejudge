FROM ubuntu:16.04

MAINTAINER Denis Arkhipenko <dabraleliid@gmail.com>

ENV LANG=C.UTF-8
ENV DEBIAN_FRONTEND     noninteractive
ENV APACHE_RUN_USER     www-data
ENV APACHE_RUN_GROUP    www-data
ENV APACHE_LOG_DIR      /var/log/apache2
ENV APACHE_PID_FILE     /var/run/apache2.pid
ENV APACHE_RUN_DIR      /var/run/apache2
ENV APACHE_LOCK_DIR     /var/lock/apache2
ENV APACHE_LOG_DIR      /var/log/apache2

ENV URL_FREEBASIC       http://downloads.sourceforge.net/fbc/FreeBASIC-1.05.0-linux-x86_64.tar.gz?download
ENV URL_EJUDGE          http://www.ejudge.ru/download/ejudge-3.6.0.tgz

ENV TZ Asia/Yekaterinburg
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get clean && apt-get update && apt-get install -y locales 

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y ntp tzdata

RUN ntpd -gq && service ntp start

RUN dpkg-reconfigure -f noninteractive tzdata

RUN locale-gen en_US.UTF-8 ru_RU.UTF-8 &&\
    update-locale LANG=ru_RU.UTF-8

RUN apt-get update &&\
    apt-get install -y wget ncurses-base libncurses-dev libncursesw5 \
                       libncursesw5-dev expat libexpat1 libexpat1-dev \
                       zlib1g-dev libelf-dev \
                       g++ gawk apache2 gettext fpc mc openjdk-8-jdk-headless \
                       libcurl4-openssl-dev libzip-dev uuid-dev bison flex sendmail \
                       mono-devel mono-runtime mono-vbnc mono-mcs \
                       ruby python python3 git
RUN groupadd ejudge &&\
    useradd ejudge -r -s /bin/bash -g ejudge &&\
    mkdir -m 0777 -p /var/www/ejudge/cgi-bin \
                     /opt/ejudge-build

RUN cd /opt &&\
    git clone https://github.com/blackav/ejudge.git &&\
    cd /opt/ejudge &&\
    ./configure --prefix=/opt/ejudge-build \
                --enable-contests-home-dir=/home/ejudge \
                --with-httpd-cgi-bin-dir=/var/www/ejudge/cgi-bin \
                --with-httpd-htdocs-dir=/var/www/ejudge/cgi-bin \
                --enable-ajax \
                --enable-charset=utf-8 &&\
    make &&\
    make install &&\
    cd /opt &&\
    chown -R ejudge:ejudge ejudge-build &&\
    \
    a2enmod cgi &&\
    rm /etc/apache2/sites-enabled/*

ADD apache/ejudge.conf /etc/apache2/sites-enabled/ejudge.conf
ADD scripts /opt/scripts
ADD images /opt/images

EXPOSE 80

VOLUME /home/ejudge
CMD ["/bin/bash", "/opt/scripts/run.sh"]
RUN ln -s /home/ejudge/000001/var/status/dir/standings.html /var/www/ejudge/cgi-bin/standings.html
ADD apache/standings.js /var/www/ejudge/cgi-bin/ejudge/standings.js
ADD apache/standings.css /var/www/ejudge/cgi-bin/ejudge/standings.css

