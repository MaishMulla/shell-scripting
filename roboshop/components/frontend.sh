#!/bin/bash

echo "-----configuring frontend-------"

echo "installing nginx"

yum install nginx -y
systemctl enable nginx