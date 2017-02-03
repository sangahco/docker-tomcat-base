FROM tomcat:7

COPY . /setup/

ENV export CATALINA_OPTS="$CATALINA_OPTS -server \
-Dfile.encoding=UTF-8 \
-Xms256m -Xmx512m -XX:PermSize=64m -XX:MaxPermSize=512m \
-Djava.awt.headless=true \
-Xloggc:$CATALINA_BASE/logs/gc.log -verbose:gc \
-XX:+PrintGCDateStamps -XX:+PrintGCDetails \
-XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=10 -XX:GCLogFileSize=100M"

RUN set -ex && \
  apt-get update && apt-get -y install \
    libxrender1 \
    libxext6 \
    libx11-6 \
    libfreetype6 \
    libfontconfig1 && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  cp /setup/phantomjs/* /usr/local/sbin/ && \
  cd /setup && wget --quiet http://download.gna.org/wkhtmltopdf/0.12/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz && \
  tar -xvf wkhtmltox-0.12.4_linux-generic-amd64.tar.xz && \
  cp wkhtmltox/bin/wkhtmltopdf /usr/local/sbin && \
  rm -rf /setup