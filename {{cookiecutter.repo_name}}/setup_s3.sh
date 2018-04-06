#!/usr/bin/env bash

#Source your vertica credentials
source .Renviron

#Generate vertica.ini from environment variables
cat << EOM > vertica.ini
[DEFAULT]
host=$vertica_host
port=$vertica_port
database=advana
user=$vertica_user
password=$vertica_password
EOM

#Get aws s3 credentials from Vertica
#Install this tool with the following command: 
#pip install git+ssh://git@github.com/massmutual/set-aws-credentials
set-aws-credentials vertica.ini data-scientist

#Source aws-credentials then remove them and vertica.ini
source ./aws-credentials.sh
rm aws-credentials.sh vertica.ini
