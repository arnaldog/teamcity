#!/usr/bin/env bash

# export JAVA_HOME=/usr/java/default
# export JAVA_HOME=/usr/lib/jvm/java-7-oracle/
HOME="/home/teamcity"
AGENT_DIR="$HOME/agent"


if [ ! -z "$DEFAULT_RUBIES" ]; then 
  echo $DEFAULT_RUBIES | xargs ruby -e "puts ARGV" | xargs rvm install
fi
if [ ! -z "$DEFAULT_GEMSETS" ]; then
  rvm all do rvm gemset create "$DEFAULT_GEMSETS"
fi

rvm all-gemsets do gem install bundler

if [ -z "$TEAMCITY_SERVER" ]; then
    echo "Fatal error: TEAMCITY_SERVER is not set."
    echo "Launch this container with -e TEAMCITY_SERVER=http://servername:port."
    echo
    exit
fi

if [ ! -d "$AGENT_DIR" ]; then
    cd $HOME
    echo "Setting up TeamCityagent for the first time..."
    echo "Agent will be installed to ${AGENT_DIR}."
    mkdir -p $AGENT_DIR
    wget $TEAMCITY_SERVER/update/buildAgent.zip
    unzip -q -d $AGENT_DIR buildAgent.zip
    rm buildAgent.zip
    chmod +x $AGENT_DIR/bin/agent.sh
    echo "serverUrl=${TEAMCITY_SERVER}" > $AGENT_DIR/conf/buildAgent.properties
    echo "workDir=../work" >> $AGENT_DIR/conf/buildAgent.properties
    echo "tempDir=../temp" >> $AGENT_DIR/conf/buildAgent.properties
    echo "systemDir=../system" >> $AGENT_DIR/conf/buildAgent.properties
else
    echo "Using agent at ${AGENT_DIR}."
fi

# Mysql Connection Forwarding
if [ -z "$MYSQL_PORT" ]; then
    echo "Fatal error: TEAMCITY_SERVER is not set."
    echo "Launch this container with -e TEAMCITY_SERVER=http://servername:port."
    echo
    exit
else
    mkdir -p /var/run/mysqld
    touch /var/run/mysqld/mysql.sock

    socat UNIX-LISTEN:/var/run/mysqld/mysqld.sock,fork,\
        reuseaddr,unlink-early,mode=777 \
        TCP:$(echo $MYSQL_PORT | cut -d"/" -f3) &
fi

# SOLR Connection Forwarding
if [ -z "$SOLR_PORT" ]; then
    echo "Fatal error: SOLR is not set."
    echo
    exit
else
    socat TCP-LISTEN:8080,fork TCP:$(echo $SOLR_PORT | cut -d"/" -f3) &
fi

# MEMCACHED Connection Forwarding
if [ -z "$MEMCACHED_PORT" ]; then
    echo "Fatal error: MEMCACHED is not set."
    echo
    exit
else
    socat TCP-LISTEN:11211,fork TCP:$(echo $MEMCACHED_PORT | cut -d"/" -f3) &
fi

# REDIS Connection Forwarding
if [ -z "$REDIS_PORT" ]; then
    echo "Fatal error: REDIS is not set."
    echo
    exit
else
    socat TCP-LISTEN:6379,fork TCP:$(echo $REDIS_PORT | cut -d"/" -f3) &
fi


sh $AGENT_DIR/bin/agent.sh run
