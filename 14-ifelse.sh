#!bin/bash

echo -e "Demo On If , If Else & Else If Usage"

ACTION=$1 

if [ "$ACTION" == "start" ] ; then 
    echo -e "\e[33m Starting Shipping Service \e[0m"
    exit 0
else 
echo -e "\e[34m Starting Shipping Service \e[0m"
fi 

echo "not meet any condition"
exit 1000