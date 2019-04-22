FROM tomcat:7.0.88

COPY . /usr/local/src/

ENV WKHTMLTOPDF=0.12.4
ENV PHANTOMJS=2.1.1

WORKDIR /usr/local/src

ADD https://s3.ap-northeast-2.amazonaws.com/sangah-b1/phantomjs-${PHANTOMJS}-linux-x86_64.tar.bz2 phantomjs.tar.bz2
ADD https://s3.ap-northeast-2.amazonaws.com/sangah-b1/wkhtmltox-${WKHTMLTOPDF}_linux-generic-amd64.tar.xz wkhtmltox.tar.xz

RUN set -e && \
  echo "deb http://cdn-fastly.deb.debian.org/debian/ jessie main" > /etc/apt/sources.list && \
  echo "deb http://security.debian.org/debian-security jessie/updates main contrib non-free" >> /etc/apt/sources.list && \
  echo "deb http://archive.debian.org/debian jessie contrib non-free" >> /etc/apt/sources.list && \
  #apt-get remove -y libssl1.1 && \
  apt-get update && apt-get -y install \
    zlib1g \
    gettext-base \
    libxrender1 \
    libxext6 \
    libx11-6 \
    libfreetype6 \
    libfontconfig1 \
    msttcorefonts \
    fontconfig \
    locales \
    nano && \
  tar -xvf wkhtmltox.tar.xz && \
  cp wkhtmltox*/bin/wkhtmltopdf /usr/local/bin && \
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
  apt-get -y autoremove && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /usr/local/src

# install Java 8
RUN set -e && \
  apt-get remove -y openjdk-7-* && \
  echo "deb http://archive.debian.org/debian jessie-backports main" >> /etc/apt/sources.list && \
  apt-get update -o Acquire::Check-Valid-Until=false && \
  apt-get -o Acquire::Check-Valid-Until=false -y install -t jessie-backports \ 
    openjdk-8-jdk \
    # libssl-dev 1.0.1 is required for wkhtmltopdf (do not install 1.1)
    libssl-dev=1.0.1t-1+deb8u8 && \
  rm /docker-java-home && ln -s /usr/lib/jvm/java-8-openjdk-amd64 /docker-java-home && \
  apt-get -y autoremove && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /usr/local/src

WORKDIR /usr/local/tomcat