Docker image with ejudge contest management system
==================================================

This image contains [ejudge contest management system](https://ejudge.ru).

System login and password are `ejudge:ejudge`.

Data stored in `/home/ejudge`

Building
========

    $ docker build -t ejudge .
    
Running
=======

    $ docker run -d --name ejudge -p 80:80 -v opt/ejudge:/home/ejudge -v /opt/problemset:/var/www/ejudge/cgi-bin/problemset ejudge

License
=======

BSD, see `LICENSE`
