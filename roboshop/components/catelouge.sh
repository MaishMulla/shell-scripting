#!/bin/bash


USER_UID=$(id -u)
COMPONENT=catalouge
LOGFILE="/tmp/${COMPONENT}.log"
COMPONET_USER="https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
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

echo -e "creating $APPUSER :"
id $APPUSER     &>> $LOGFILE
if  [ $? -ne 0 ] ; then

useradd $APPUSER
stat $?
else 
echo -e "skipping"
fi

echo -n "downloading $COMPONENT :"
curl -s -L -o /tmp/$COMPONENTe.zip $COMPONET_USER
stat $?

echo -e "extracting $COMPONET"