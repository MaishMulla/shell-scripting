# !/bin/bash

USER_UID=$(id -u)
COMPONENT=mongodb
LOGFILE="/tmp/${COMPONENT}.log"
MONGO_REPO="https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo"
SCHEMA_URL="https://github.com/stans-robot-project/mongodb/archive/main.zip"

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

echo "-----configuring ${COMPONENT}-------"

echo -n "configuring ${COMPONENT} repo :"
curl -s -o /etc/yum.repos.d/mongodb.repo $MONGO_REPO
stat $?

echo -n "installing $COMPONENT :"
yum install -y mongodb-org  &>> {$LOGFILE}
stat $?

echo -n "enabling $COMPONENT visibility "
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
stat $?

echo -n "starting $COMPONENT :"
systemctl enable mongod     &>> $LOGFILE
systemctl daemon-reload      &>> $LOGFILE
systemctl restart mongod       &>> $LOGFILE
stat $?

echo -n "downloading $COMPONENT schema :"
curl -s -L -o /tmp/mongodb.zip $SCHEMA_URL
stat $?

echo -n "extracting $COMPONENT :"
cd /tmp
unzip -o mongodb.zip    &>> $LOGFILE
stat $?

echo -n "injecting schema "
cd  /tmp/mongodb-main
mongo < catalogue.js     &>> $LOGFILE
mongo < users.js          &>> $LOGFILE
stat $?

