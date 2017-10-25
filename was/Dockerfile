FROM tomcat:7

COPY . /usr/local/src/

ENV WKHTMLTOPDF=0.12.2.1
ENV PHANTOMJS=2.1.1

WORKDIR /usr/local/src

ADD https://s3.ap-northeast-2.amazonaws.com/sangah-b1/phantomjs-${PHANTOMJS}-linux-x86_64.tar.bz2 phantomjs.tar.bz2
ADD https://s3.ap-northeast-2.amazonaws.com/sangah-b1/wkhtmltox-${WKHTMLTOPDF}_linux-jessie-amd64.deb wkhtmltox.deb

RUN set -e && \
  echo "deb http://security.debian.org/ jessie/updates contrib non-free" >> /etc/apt/sources.list && \
  echo "deb http://deb.debian.org/debian jessie contrib non-free" >> /etc/apt/sources.list && \
  echo "deb http://deb.debian.org/debian jessie-updates contrib non-free" >> /etc/apt/sources.list && \
  apt-get update && apt-get -y install \
    gettext-base \
    libxrender1 \
    libxext6 \
    libx11-6 \
    libfreetype6 \
    libfontconfig1 \
    msttcorefonts \
    fontconfig \
    xfonts-base \
    xfonts-75dpi \
    locales \
    nano && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  dpkg -i wkhtmltox.deb && \
  ln -s /usr/local/bin/wkhtmltopdf /usr/local/sbin/wkhtmltopdf && \
  tar -xf phantomjs.tar.bz2 && \
  cp phantomjs*/bin/phantomjs /usr/local/sbin && \
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