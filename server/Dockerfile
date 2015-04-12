# Dockerfile for Teamcity Server
#

# Official Java Docker Image
FROM java:7

# Build teamcity Server from 
# TeamCity data is stored in a volume to facilitate container upgrade
# VOLUME  ["/data/teamcity"]
# ENV TEAMCITY_DATA_PATH /data/teamcity


# TeamCity data is stored in a volume to facilitate container upgrade
VOLUME  ["/data/teamcity"]
ENV TEAMCITY_DATA_PATH /data/teamcity
#
# # Download and install TeamCity to /opt
RUN apt-get install -y -q \
    build-essential \
    wget \
    tar \
    unzip

ENV TEAMCITY_PACKAGE TeamCity-8.1.5.tar.gz
ENV TEAMCITY_DOWNLOAD http://download.jetbrains.com/teamcity
RUN wget $TEAMCITY_DOWNLOAD/$TEAMCITY_PACKAGE && \
tar zxf $TEAMCITY_PACKAGE -C /opt && \
rm -rf $TEAMCITY_PACKAGE

# Github teamcity plugin

RUN wget http://teamcity.jetbrains.com/guestAuth/repository/download/bt398/lastest.lastSuccessful/teamcity.github.zip && \
    mkdir -p $TEAMCITY_DATA_PATH/plugins && \
    mv teamcity.github.zip  $TEAMCITY_DATA_PATH/plugins

# MYSQL
#RUN wget  http://dev.mysql.com/downloads/connector/ ->  /data/teamcity/lib/jdbc
EXPOSE 8111
CMD ["/opt/TeamCity/bin/teamcity-server.sh", "run"]


