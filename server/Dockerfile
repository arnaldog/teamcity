# Dockerfile for Teamcity Server
#

# Official Java Docker Image
FROM java:8

# Build teamcity Server from 
# TeamCity data is stored in a volume to facilitate container upgrade
# VOLUME  ["/data/teamcity"]
# ENV TEAMCITY_DATA_PATH /data/teamcity


# TeamCity data is stored in a volume to facilitate container upgrade
VOLUME  ["/data/teamcity"]
ENV TEAMCITY_DATA_PATH /data/teamcity
#
# # Download and install TeamCity to /opt
RUN apt-get update
RUN apt-get install -y -q \
    build-essential \
    wget \
    tar \
    unzip

# Installing TeamCity Server
ENV TEAMCITY_PACKAGE TeamCity-9.0.3.tar.gz
ENV TEAMCITY_DOWNLOAD http://download.jetbrains.com/teamcity

RUN wget $TEAMCITY_DOWNLOAD/$TEAMCITY_PACKAGE && \
    tar zxf $TEAMCITY_PACKAGE -C /opt && \
    rm -rf $TEAMCITY_PACKAGE

# Github teamcity plugin
ADD http://teamcity.jetbrains.com/guestAuth/repository/download/bt398/lastest.lastSuccessful/teamcity.github.zip /data/teamcity/plugins/teamcity.github.zip

EXPOSE 8111
CMD ["/opt/TeamCity/bin/teamcity-server.sh", "run"]


