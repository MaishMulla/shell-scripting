#!/bin/bash

bash components/$1.sh

<<COMMENT
if [ $? -ne 0 ] ; then
echo -e "\e[31m example useage: \e[0m bash wraper.sh componentName"
exit 30

fi 
>>COMMENT