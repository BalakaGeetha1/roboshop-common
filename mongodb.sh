#!/bin/bash

source ./common.sh

check_root

cp mongo.repo /etc/yum.repos.d/mongo.repo
VALIDATE $? "Adding Mongo repo"

dnf install mongodb-org -y &>>$LOG_FILE
VALIDATE $? "Intsalling Mongo db"

systemctl enable mongod &>>$LOG_FILE
VALIDATE $? "Validate enabling Mongo db"

systemctl start mongod &>>$LOG_FILE
VALIDATE $? "Validate start mongodb"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
VALIDATE $? "Allowing remote connections to MongoDb"


systemctl restart mongod
VALIDATE $? "Restarted Mongodb"

TOTAL_TIME
