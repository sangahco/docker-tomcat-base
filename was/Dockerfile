FROM tomcat:8.5-jdk8-openjdk
LABEL maintainer="Emanuele Disco <emanuele.disco@gmail.com>"

COPY . /usr/local/src/

ENV WKHTMLTOPDF=0.12.6
ENV PHANTOMJS=2.1.1

WORKDIR /usr/local/src

ADD https://s3.ap-northeast-2.amazonaws.com/sangah-b1/phantomjs-${PHANTOMJS}-linux-x86_64.tar.bz2 phantomjs.tar.bz2
ADD https://sangah-b1.s3.ap-northeast-2.amazonaws.com/wkhtmltox_${WKHTMLTOPDF}-1.buster_amd64.deb wkhtmltox.deb

RUN set -e && \
  echo "deb http://security.debian.org/ buster/updates contrib non-free" >> /etc/apt/sources.list && \
  echo "deb http://deb.debian.org/debian buster contrib non-free" >> /etc/apt/sources.list && \
  echo "deb http://deb.debian.org/debian buster-updates contrib non-free" >> /etc/apt/sources.list && \
  #apt-get remove -y libssl1.1 && \
  apt-get update && apt-get -y install \
    # libssl1.0.2 and libssl1.0-dev are required by wkhtmltopdf
    #libssl1.0.2 \
    #libssl1.0-dev \
    libxrender1 \
    libxext6 \
    libx11-6 \
    libjpeg62-turbo \
    xfonts-75dpi \
    xfonts-base \
    msttcorefonts \
    fontconfig \
    locales \
    nano \
    # for phantomjs?
    zlib1g \
    gettext-base \
    libfreetype6 \
    libfontconfig1 && \
  # wkhtmltopdf setup
  dpkg -i wkhtmltox.deb && \
  #ln -s /usr/local/bin/wkhtmltopdf /usr/local/sbin/wkhtmltopdf && \
  # phantomjs setup
  tar -xf phantomjs.tar.bz2 && \
  #cp phantomjs*/bin/phantomjs /usr/local/sbin && \
  mkdir -p /usr/share/phantomjs/bin && \
  touch /usr/share/phantomjs/openssl.cnf && \
  cp phantomjs*/bin/phantomjs /usr/share/phantomjs/bin && \
  cp etc/phantomjs /usr/local/sbin && \
  chmod a+x /usr/local/sbin/* && \
  # fonts setup
  cp fonts/* /usr/local/share/fonts && \
  fc-cache -fv && \
  # locale setup
  sed -i -e 's/# ko_KR.UTF-8 UTF-8/ko_KR.UTF-8 UTF-8/' /etc/locale.gen && \
  echo 'LANG="ko_KR.UTF-8"'>/etc/default/locale && \
  dpkg-reconfigure --frontend=noninteractive locales && \
  update-locale LANG=ko_KR.UTF-8 && \
  # tomcat setup
  cp setenv.sh /usr/local/tomcat/bin && \
  chmod a+x /usr/local/tomcat/bin/setenv.sh && \
  # cleanup
  apt-get -y autoremove && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /usr/local/src

WORKDIR /usr/local/tomcat