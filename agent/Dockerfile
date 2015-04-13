FROM java:7
MAINTAINER arnaldog@gmail.com Arnaldo Gaspar V.

# Update apt
RUN apt-get update 

# Add google chrome Keystore
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

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
    google-chrome-stable

# install RVM, Ruby, and Bundler
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN \curl -L https://get.rvm.io | bash -s stable
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install 2.2.1"
RUN /bin/bash -l -c "rvm install 2.1.2"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"
RUN echo "source /usr/local/rvm/scripts/rvm" >> /etc/profile
RUN source /usr/local/rvm/scripts/rvm

RUN wget -O /tmp/chromedriver.zip http://chromedriver.googlecode.com/files/chromedriver_linux64_19.0.1068.0.zip && unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/;
RUN adduser teamcity
EVN TERM linux

EXPOSE 9090
ADD setup-agent.sh /setup-agent.sh

CMD sh -c "TEAMCITY_SERVER=$TEAMCITY_SERVER bash /setup-agent.sh run"