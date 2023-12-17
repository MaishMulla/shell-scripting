# !/bin/bash

USER_UID=$(id -u)
COMPONENT=frontend
LOGFILE="/tmp/${COMPOENT}.log"

start()
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

echo "-----configuring ${COMPONENT}-------"
echo -n "installing nginx :"

yum install nginx -y     &>> $LOGFILE
start $?

echo -n "downloading the component $COMPONENT :"
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
start $?
 
echo -n "clening the $COMPONENT :"        
 cd /usr/share/nginx/html
 rm -rf *  &>> $ {LOGFILE}
 start $?

echo -n "extracting ${COMPONENT} "
unzip -o /tmp/${COMPONENT}.zip     &>> $LOGFILE
start $?

echo -n "configuring $COMPONENT :"
 mv ${COMPONENT}-main/* .
 mv static/* .
 rm -rf ${COMPONENT}-main README.md
 mv localhost.conf /etc/nginx/default.d/roboshop.conf
start $?

echo -n "restarting: $COMPONENT"

systemctl enable nginx      &>> $LOGFILE
systemctl daemon-reload      &>> $LOGFILE
systemctl start nginx        &>> $LOGFILE
start $?
