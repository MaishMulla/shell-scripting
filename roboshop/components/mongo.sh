# !/bin/bash

USER_UID=$(id -u)
COMPONENT=mongo
LOGFILE="/tmp/${COMPOENT}.log"
MONGO_REPO="https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo"

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

echo -n "configuring ${COMPONENT} repo"
curl -s -o /etc/yum.repos.d/mongodb.repo $MONGO_REPO
start $?

echo -n "installing $COMPONENT "
yum install -y mongodb-org &>> ${LOGFILE}
start $?

echo -n "enabling $COMPONENT visibility "
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
start $?

echo -n "starting $COMPONENT"
systemctl enable mongod     &>> $LOGFILE
systemctl daemon-reload      &>> $LOGFILE
systemctl restart mongod       &>> $LOGFILE
start $?


