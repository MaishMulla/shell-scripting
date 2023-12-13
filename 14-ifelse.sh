#!bin/bash

echo -e "Demo On If , If Else & Else If Usage"

ACTION=$1 

if [ "$ACTION" == "start" ] ; then 
    echo -e "\e[33m Starting Shipping Service \e[0m"
    exit 0

elif [ "$ACTION" == "stop" ] ; then 
    echo -e "\e[32m Stoping Shipping Service \e[0m"
    exit 0

    elif [ "$ACTION" == "restart" ] ; then 
    echo -e "\e[31m restart Shipping Service \e[0m"
    exit 0

else 
echo -e "\e[34m valid option is starts - stops - restarts \e[0m"

fi 

