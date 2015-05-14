FROM ubuntu:14.04
MAINTAINER arnaldog@gmail.com Arnaldo Gaspar V.

# Update apt
RUN apt-get -y -q update 
RUN apt-get -y -q upgrade

# # Download and install all essentials
RUN apt-get install -y -q \
    build-essential \
    wget \
    tar \
    unzip \
    socat \
    mysql-client \
    mysql-server \
    libicu-dev \
    zlib1g-dev \
    libxslt-dev \
    libxml2-dev \
    libmysqlclient-dev \
    libfontconfig1-dev \
    chrpath \
    libssl-dev \
    git-core \
    flex \
    bison \
    gperf \
    ruby \
    perl \
    libsqlite3-dev \
    libfreetype6 \
    libssl-dev \
    libpng-dev \
    libjpeg-dev \
    nodejs-legacy \
    nodejs \
    npm \
    curl \
    lsof \
    procps \
    redis-server \
    memcached \
    openjdk-7-jdk

# install RVM, Ruby, and Bundler
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN \curl -L https://get.rvm.io | bash -s stable

ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

ENV DEFAULT_GEMSETS=myproject
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install 2.1.2" 
RUN /bin/bash -l -c "rvm all do rvm gemset create $DEFAULT_GEMSETS" 

RUN npm install phantomjs --phantomjs_cdnurl=http://cnpmjs.org/downloads
RUN ln -s /node_modules/.bin/phantomjs  /usr/bin/phantomjs & \
    ln -s /node_modules/.bin/phantomjs  /usr/sbin/phantomjs

# Solr
ENV SOLR_VERSION 4.10.4
ENV SOLR solr-$SOLR_VERSION
ENV SOLR_PATH /opt/solr

RUN mkdir -p /opt && \
    wget -nv --output-document=/opt/$SOLR.tgz \
    http://archive.apache.org/dist/lucene/solr/$SOLR_VERSION/$SOLR.tgz && \
    tar -C /opt --extract --file /opt/$SOLR.tgz && \
    rm /opt/$SOLR.tgz && \
    ln -s /opt/$SOLR /opt/solr

ENV DEFAULT_CORE=mycore
ENV CORE_PATH=/opt/solr/example/solr
ENV DEFAULT_CORE_PATH=$CORE_PATH/$DEFAULT_CORE

RUN cp -r $CORE_PATH/collection1 $DEFAULT_CORE_PATH
RUN echo 'name=$DEFAULT_CORE' > $DEFAULT_CORE_PATH/core.properties

ADD solr/schema.xml $DEFAULT_CORE_PATH/conf/schema.yml



EXPOSE 9090
EXPOSE 8983

ADD setup-agent.sh /setup-agent.sh
RUN mkdir -p /home/teamcity/agent
CMD sh -c "TEAMCITY_SERVER=$TEAMCITY_SERVER bash /setup-agent.sh run"
