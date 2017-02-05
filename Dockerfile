FROM tomcat:7

COPY . /usr/local/src/

ENV WKHTMLTOPDF=0.12.4
ENV PHANTOMJS=2.1.1

RUN set -ex && \
  apt-get update && apt-get -y install \
    libxrender1 \
    libxext6 \
    libx11-6 \
    libfreetype6 \
    libfontconfig1 && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  cd /usr/local/src && wget --quiet https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-${PHANTOMJS}-linux-x86_64.tar.bz2 && \
  tar -xvf phantomjs-${PHANTOMJS}-linux-x86_64.tar.bz2 && \
  cp phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/sbin && \
  cd /usr/local/src && wget --quiet http://download.gna.org/wkhtmltopdf/0.12/${WKHTMLTOPDF}/wkhtmltox-${WKHTMLTOPDF}_linux-generic-amd64.tar.xz && \
  tar -xvf wkhtmltox-${WKHTMLTOPDF}_linux-generic-amd64.tar.xz && \
  cp wkhtmltox/bin/wkhtmltopdf /usr/local/sbin && \
  chmod a+x /usr/local/sbin/* && \
  rm -rf /usr/local/src