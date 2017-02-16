FROM tomcat:7

COPY . /usr/local/src/

ENV WKHTMLTOPDF=0.12.4
ENV PHANTOMJS=2.1.1

WORKDIR /usr/local/src

ADD http://dev.sangah.com/owncloud/index.php/s/kcZMl6PLxws1n7A/download phantomjs.tar.bz2
ADD http://dev.sangah.com/owncloud/index.php/s/8XtHeBVpN4g64kW/download wkhtmltox.tar.xz

RUN set -ex && \
  echo "deb http://security.debian.org/ jessie/updates contrib non-free" >> /etc/apt/sources.list && \
  echo "deb http://deb.debian.org/debian jessie contrib non-free" >> /etc/apt/sources.list && \
  echo "deb http://deb.debian.org/debian jessie-updates contrib non-free" >> /etc/apt/sources.list && \
  apt-get update && apt-get -y install \
    libxrender1 \
    libxext6 \
    libx11-6 \
    libfreetype6 \
    libfontconfig1 \
    msttcorefonts \
    fontconfig \
    locales \
    nano && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  tar -xf phantomjs.tar.bz2 && \
  cp phantomjs*/bin/phantomjs /usr/local/sbin && \
  tar -xf wkhtmltox.tar.xz && \
  cp wkhtmltox*/bin/wkhtmltopdf /usr/local/sbin && \
  chmod a+x /usr/local/sbin/* && \
  cp fonts/* /usr/local/share/fonts && \
  fc-cache -fv && \
  sed -i -e 's/# ko_KR.UTF-8 UTF-8/ko_KR.UTF-8 UTF-8/' /etc/locale.gen && \
  echo 'LANG="ko_KR.UTF-8"'>/etc/default/locale && \
  dpkg-reconfigure --frontend=noninteractive locales && \
  update-locale LANG=ko_KR.UTF-8 && \
  cp setenv.sh /usr/local/tomcat/bin && \
  chmod a+x /usr/local/tomcat/bin/setenv.sh && \
  rm -rf /usr/local/src

WORKDIR /usr/local/tomcat