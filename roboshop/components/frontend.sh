#!/bin/bash

UID=$(id -u)

if [ $UID -ne 0 ] ; then 
echo -e " \e[33m this script i would like to run as root user \e[0m"
echo -e "\e[32m example usages : \n\t\t \e[om sudo bash scriptname componentName"
exit 1 

 
fi

echo "-----configuring frontend-------"
echo "installing nginx"

yum install nginx -y
