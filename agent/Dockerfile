FROM java:8
MAINTAINER arnaldog@gmail.com Arnaldo Gaspar V.

# Update apt
RUN apt-get update 
# # Download and install TeamCity to /opt
RUN apt-get install -y -q \
    build-essential \
    wget \
    tar \
    unzip \
    socat \
    mysql-client \
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
    node-legacy \
    nodejs \
    npm


# install RVM, Ruby, and Bundler
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN \curl -L https://get.rvm.io | bash -s stable

ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install 2.2.1"
RUN /bin/bash -l -c "rvm install 2.1.2"
RUN /bin/bash -l -c "rvm 2.1.2 do gem install bundler --no-ri --no-rdoc"
RUN /bin/bash -l -c "rvm 2.2.1 do gem install bundler --no-ri --no-rdoc"

# Phantomjs

RUN npm install phantomjs --phantomjs_cdnurl=http://cnpmjs.org/downloads \
    ln -s /node_modules/.bin/phantomjs  /usr/bin/phantomjs \
    ln -s /node_modules/.bin/phantomjs  /usr/sbin/phantomjs

EXPOSE 9090
ADD setup-agent.sh /setup-agent.sh

CMD sh -c "TEAMCITY_SERVER=$TEAMCITY_SERVER bash /setup-agent.sh run"
