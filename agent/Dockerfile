FROM java:7
MAINTAINER arnaldog@gmail.com Arnaldo Gaspar V.

# Update apt
RUN apt-get update 

# # Download and install TeamCity to /opt
RUN apt-get install -y -q \
    build-essential \
    wget \
    tar \
    unzip \
    socat

# install RVM, Ruby, and Bundler
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN \curl -L https://get.rvm.io | bash -s stable
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install 2.2.1"
RUN /bin/bash -l -c "rvm install 2.1.2"
RUN /bin/bash -l -c "rvm install 1.9.3"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"
RUN echo "source /usr/local/rvm/scripts/rvm" >> /etc/profile


RUN adduser teamcity

EXPOSE 9090
ADD setup-agent.sh /setup-agent.sh
CMD sh -c "TEAMCITY_SERVER=$TEAMCITY_SERVER bash /setup-agent.sh run"
