#!/usr/bin/env bash

WORKSPACE=$1
SCHEMA_NAME=$2

export JENKINS_HOME=/jenkins/
export lquser=`aws secretsmanager get-secret-value --secret-id stageAppDBRDS --region us-east-1   | jq --raw-output .SecretString | jq -r ."username"`
export lqpassword=`aws secretsmanager get-secret-value --secret-id stageAppDBRDS --region us-east-1   | jq --raw-output .SecretString | jq -r ."password"`
export hostname=`aws secretsmanager get-secret-value --secret-id stageAppDBRDS --region us-east-1   | jq --raw-output .SecretString | jq -r ."host"`
export portnumber=`aws secretsmanager get-secret-value --secret-id stageAppDBRDS --region us-east-1   | jq --raw-output .SecretString | jq -r ."port"`

docker run -v $WORKSPACE:$WORKSPACE -v $JENKINS_HOME:$JENKINS_HOME liquibase/liquibase:4.27 \
--url=jdbc:mysql://$hostname:$portnumber/$SCHEMA_NAME \
--username=$lquser \
--password=$lqpassword \
--changeLogFile=$SCHEMA_NAME.root.changelog.xml \
--driver=com.mysql.cj.jdbc.Driver \
--classpath=$JENKINS_HOME/liquibase/internal/lib/mysql-connector-java-8.0.23.jar \
--searchPath=$WORKSPACE \
updateSQL
