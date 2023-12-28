#!/bin/bash


USER_ID=$(id -u)
COMPONENT=catalogue
COMPONENT_URL="https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
LOGFILE="/tmp/${COMPONENT}.log"
APPUSER="roboshop"
APPUSER_HOME="/home/${APPUSER}/${COMPONENT}"


stat()
{
    if [ $1 -eq 0 ] ; then
    echo "success"
else 
    echo "fail"
fi
}

if [ $USER_ID -ne 0 ] ; then 
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
curl -s -L -o /tmp/$COMPONENT.zip $COMPONENT_URL
stat $?

echo -e "extracting $COMPONENT :"
cd /home/roboshop
unzip -o /tmp/${COMPONENT}.zip        &>> $LOGFILE
stat $?

echo -n "configuring  $COMPONENT permission :"
mv ${APPUSER_HOME}-main $APPUSER_HOME
chown -R $APPUSER:$APPUSER $APPUSER_HOME 
chmod -R 770 $APPUSER_HOME
stat $?

echo -n "generating artifacts "
cd $APPUSER_HOME
npm install      &>> $LOGFILE
stat $?