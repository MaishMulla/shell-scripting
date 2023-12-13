#!bin/bash

echo -e "Demo On If , If Else & Else If Usage"

ACTION=$11 

if [ "$ACTION" == "start" ] ; then 
    echo -e "\e[33m Starting Shipping Service \e[0m"
    exit 0

fi 

echo "not meet any condition"
exit 1000