## Base Tomcat Image for PMIS Application

This is an Apache Tomcat image with PhantomJS and wkhtmltopdf available under `/usr/local/sbin` folder.

The correct build command and image name is the following:

    $ docker -t tomcat-base .

You push the image into the registry with:

    $ docker tag tomcat-base dev.sangah.com:5043/tomcat-base
    $ docker login dev.sangah.com:5043
    $ docker push dev.sangah.com:5043/tomcat-base