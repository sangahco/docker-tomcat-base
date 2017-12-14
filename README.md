[![HitCount](http://hits.dwyl.io/sangahco/sangahco/docker-tomcat-base.svg)](http://hits.dwyl.io/sangahco/sangahco/docker-tomcat-base)
[![Jenkins](https://img.shields.io/jenkins/s/https/dev.builder.sangah.com/job/tomcat-base.svg?style=flat-square&label=stable)]()
[![Jenkins](https://img.shields.io/jenkins/s/https/dev.builder.sangah.com/job/tomcat-base-jessie-jre8.svg?style=flat-square&label=jessie-jre8)]()
[![Jenkins](https://img.shields.io/jenkins/s/https/dev.builder.sangah.com/job/tomcat-base-stretch-jre8.svg?style=flat-square&label=stretch-jre8)]()

# Base Tomcat Image for PMIS Application

This image contains an *Apache Tomcat* environment with *PhantomJS* and *wkhtmltopdf* 
available under `/usr/local/sbin` folder.

The correct build command and image name is as below:

    $ docker -t tomcat-base .

You can push the image into our registry with:

    $ docker tag tomcat-base dev.sangah.com:5043/tomcat-base
    $ docker login dev.sangah.com:5043
    $ docker push dev.sangah.com:5043/tomcat-base

## Basic Execution

Set the variable `HTTP_PORT` to a port to bind to the Tomcat instance 
and run the container using `docker-compose` with:

    $ docker-compose up


## Java Management Extensions (JMX)

To use *JMX* functionality change the varialbe `JMX_PORT` and `JMX_HOST` inside the `.env` file
or export these variables before executing the `docker-compose` using `docker-compose-jmx.yml` as configuration file.

    $ docker-compose -f docker-compose-jmx.yml up
