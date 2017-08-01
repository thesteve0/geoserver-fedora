FROM thesteve0/tomcat:latest

ENV GEOSERVER_DATA_DIR="/geoserver_data/data"
#GEOWEBCACHE_CACHE_DIR=<path>

USER root
#install Geoserver
#Download the geoserver war file  CHANGEME
RUN cd /tmp && wget http://sourceforge.net/projects/geoserver/files/GeoServer/2.11.2/geoserver-2.11.2-war.zip && \
    unzip  geoserver-2.11.2-war.zip && \
    unzip geoserver.war -d geoserver && \
    rm -rf /apache-tomcat-8.5.16/webapps/ROOT && \
    mv geoserver /apache-tomcat-8.5.16/webapps/ROOT && \
    mkdir -p $GEOSERVER_DATA_DIR && \
    rm -rf /tmp/*

COPY files/WEB-INF/web.xml  /apache-tomcat-8.5.16/webapps/ROOT/WEB-INF/

#may want to make a volume for the caching directory

#Make a volume mount for the data dir
VOLUME ["$GEOSERVER_DATA_DIR"]

EXPOSE 8080

USER 1001

#Run tomcat
#CMD ["/apache-tomcat-8.5.16/bin/startup.sh"]
