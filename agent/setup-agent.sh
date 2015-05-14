#!/usr/bin/env bash

# export JAVA_HOME=/usr/java/default
# export JAVA_HOME=/usr/lib/jvm/java-7-oracle/


if [ -z "$TEAMCITY_SERVER" ]; then
    echo "Fatal error: TEAMCITY_SERVER is not set."
    echo "Launch this container with -e TEAMCITY_SERVER=http://servername:port."
    echo
    exit
fi

if [ ! -d "$AGENT_DIR" ]; then
    cd $HOME
    AGENT_DIR=/home/teamcity/agent
    echo "Setting up TeamCityagent for the first time..."
    echo "Agent will be installed to ${AGENT_DIR}."
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

/etc/init.d/mysql start
[ ! -z $DEFAULT_DATABASE ] &&  mysql -u root -e 'create database $DEFAULT_DATABASE'
/opt/solr/bin/solr -f -p 8080 &
sh $AGENT_DIR/bin/agent.sh run
