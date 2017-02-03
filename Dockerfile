FROM tomcat:7

COPY . /setup/

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
  cd ~ && wget http://download.gna.org/wkhtmltopdf/0.12/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz && \
  tar -xvf wkhtmltox-0.12.4_linux-generic-amd64.tar.xz && \
  cp wkhtmltox/bin/wkhtmltopdf /usr/local/sbin && \
  rm -rf /setup