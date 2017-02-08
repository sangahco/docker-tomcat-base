FROM tomcat:7

COPY . /usr/local/src/

ENV WKHTMLTOPDF=0.12.4
ENV PHANTOMJS=2.1.1

WORKDIR /usr/local/src

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
  wget --quiet https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-${PHANTOMJS}-linux-x86_64.tar.bz2 && \
    tar -xf phantomjs-${PHANTOMJS}-linux-x86_64.tar.bz2 && \
    cp phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/sbin && \
  wget --quiet http://download.gna.org/wkhtmltopdf/0.12/${WKHTMLTOPDF}/wkhtmltox-${WKHTMLTOPDF}_linux-generic-amd64.tar.xz && \
    tar -xf wkhtmltox-${WKHTMLTOPDF}_linux-generic-amd64.tar.xz && \
    cp wkhtmltox/bin/wkhtmltopdf /usr/local/sbin && \
  chmod a+x /usr/local/sbin/* && \
  cp fonts/* /usr/local/share/fonts && \
    fc-cache -fv && \
  sed -i -e 's/# ko_KR.UTF-8 UTF-8/ko_KR.UTF-8 UTF-8/' /etc/locale.gen && \
    echo 'LANG="ko_KR.UTF-8"'>/etc/default/locale && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=ko_KR.UTF-8 && \
  rm -rf /usr/local/src

# The -Djava.security.egd=file:/dev/./urandom resolve the really slow startup due to low entropy in virtual environment
# https://fbrx.github.io/post/fixing-tomcat-startup-performance-on-cloud-servers/
# https://wiki.apache.org/tomcat/HowTo/FasterStartUp
# http://marc.info/?l=tomcat-user&m=132769606728228&w=2
RUN echo "CATALINA_OPTS=${CATALINA_OPTS} -server \
-Dfile.encoding=UTF-8 \
-Xms256m -Xmx${JAVA_MAX_SIZE:-512m} -XX:PermSize=64m -XX:MaxPermSize=512m \
-Djava.awt.headless=true \
-Djava.security.egd=file:/dev/./urandom \
-Xloggc:${CATALINA_HOME}/logs/gc.log -verbose:gc \
-XX:+PrintGCDateStamps -XX:+PrintGCDetails \
-XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=10 -XX:GCLogFileSize=100M" >> /usr/local/tomcat/bin/setenv.sh && \
chmod a+x /usr/local/tomcat/bin/setenv.sh

WORKDIR /usr/local/tomcat