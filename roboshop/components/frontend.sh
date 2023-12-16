#!/bin/bash

USER_UID=$(id -u)
COMPONENT=$1

if [ $USER_UID -ne 0 ] ; then 
echo -e " \e[33m this script i would like to run as root user \e[0m"
echo -e "\e[32m example usages : \n\t\t \e[om sudo bash scriptname componentName"
exit 1 

 
fi

echo "-----configuring frontend-------"
echo -n"installing nginx"

yum install nginx -y     &>> /tmp/frontend.log

if [ $? -eq 0 ] ; then
    echo "success"
else 
    echo "fail"
fi
 echo "downloading the component $1"

 # curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
 if [ $? -eq 0 ] ; then
    echo "success"
else 
    echo "fail"
fi
