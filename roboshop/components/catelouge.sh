#!/bin/bash


USER_UID=$(id -u)
COMPONENT=catalouge
LOGFILE="/tmp/${COMPONENT}.log"
APPUSER="roboshop"

stat()
{
    if [ $? -eq 0 ] ; then
    echo "success"
else 
    echo "fail"
fi
}

if [ $USER_UID -ne 0 ] ; then 
echo -e "\e[33m this script i would like to run as root user \e[0m"
echo -e "\e[32m example usages : \n\t\t \e[om sudo bash scriptname componentName"
exit 1 
fi

#echo -n "configuring Nodejs repo :"
#yum install https://rpm.nodesource.com/pub_16.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm -y
#stat $?  

echo -n "installing nodeJS :"
yum install nodejs -y     &>> $LOGFILE
stat $?

id $APPUSER     &>> $LOGFILE
if  [ $? -ne 0] ;then
echo -e "creating $APPUSER :"
useradd $APPUSER
stat $?
else 
echo -e "skipping"
fi

