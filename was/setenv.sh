#!/usr/bin/env sh

# The -Djava.security.egd=file:/dev/./urandom resolve the really slow startup due to low entropy in virtual environment
# https://fbrx.github.io/post/fixing-tomcat-startup-performance-on-cloud-servers/
# https://wiki.apache.org/tomcat/HowTo/FasterStartUp
# http://marc.info/?l=tomcat-user&m=132769606728228&w=2

CATALINA_OPTS="${CATALINA_OPTS} -server \
-Dfile.encoding=UTF-8 \
-Xms256m -Xmx\${JAVA_MAX_SIZE:-512m} -XX:PermSize=64m -XX:MaxPermSize=512m \
-Djava.awt.headless=true \
-Djava.security.egd=file:/dev/./urandom \
-Xloggc:\${CATALINA_HOME}/logs/gc.log -verbose:gc \
-XX:+PrintGCDateStamps -XX:+PrintGCDetails \
-XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=10 -XX:GCLogFileSize=100M"

if [ -z "$JMX_HOST" ]; then
    JMX_HOST=$HOSTNAME
fi

if [ -n "$JMX_PORT" ]; then
    CATALINA_OPTS="$CATALINA_OPTS \
    -Dcom.sun.management.jmxremote=true \
    -Dcom.sun.management.jmxremote.local.only=false \
    -Dcom.sun.management.jmxremote.port=\${JMX_PORT} \
    -Dcom.sun.management.jmxremote.rmi.port=\${JMX_PORT} \
    -Dcom.sun.management.jmxremote.ssl=false \
    -Dcom.sun.management.jmxremote.authenticate=false \
    -Djava.rmi.server.hostname=${JMX_HOST}"
fi