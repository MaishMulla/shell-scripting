#!/bin/bash

USER_UID=$(id -u)
COMPONENT=$1

if [ $USER_UID -ne 0 ] ; then 
echo -e " \e[33m this script i would like to run as root user \e[0m"
echo -e "\e[32m example usages : \n\t\t \e[om sudo bash scriptname componentName"
exit 1 

 
fi

echo "-----configuring frontend-------"
echo -n "installing nginx :"

yum install nginx -y     &>> /tmp/frontend.log

if [ $? -eq 0 ] ; then
    echo "success"
else 
    echo "fail"
fi
 echo -n "downloading the $1 component :"

 # curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
 if [ $? -eq 0 ] ; then
    echo "success"
else 
    echo "fail"
fi

echo -n "clening the  $1 component :"        
 cd /usr/share/nginx/html
 rm -rf *  &>> /tmp/frontend.log
 if [ $? -eq 0 ] ; then
    echo "success"
else 
    echo "fail"
fi

echo "extracting $1: "
unzip /tmp/frontend.zip   &>> /tmp/frontend.log
if [ $? -eq 0 ] ; then
    echo "success"
else 
    echo "fail"
fi

echo "configuring $1:"
 mv frontend-main/* .
 mv static/* .
 rm -rf frontend-main README.md
 mv localhost.conf /etc/nginx/default.d/roboshop.conf

if [ $? -eq 0 ] ; then
    echo "success"
else 
    echo "fail"
fi

echo -n "restarting $1"

systemctl enable nginx     &>> /tmp/frontend.log
systemctl daemon-reload      &>> /tmp/frontend.log
systemctl start nginx       &>> /tmp/frontend.log

if [ $? -eq 0 ] ; then
    echo "success"
else 
    echo "fail"
fi
