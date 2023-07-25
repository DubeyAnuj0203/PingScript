#!/bin/bash

#Geting the path of ip list file...
file_path="/root/ip"

#color coding..

notactive='\033[0;31m'
active='\033[0;32m'
info='\033[0;33m'
back_to_default='\033[0m'
header='\033[0;37m'


#Pinging phase...
function file_check_ping_scan(){
        echo -e "${info}Finding ip file in existing folder..."
        sleep 2

#checking if cmd is executed or not
        if [ "$(echo $?)" -eq 0 ]
        then
                echo "ip file found..."
                sleep 1
                echo " "

                echo -e  "${header}STATUS\t\tIP-ADDRESS"
                for ip in $(cat $file_path)
                do
                        ping -c 1 -W 1 $ip >/dev/null 2>&1
                        if [ "$(echo $?)" -eq 0 ]
                        then
                                echo -e "${active}Reachable\t$ip${NC}"
                        else
                                echo -e "${notactive}Not-Reachable\t$ip${back_to_default}"
                        fi
                        sleep 2
                done
        else
                echo "somethig is not right.."
        fi
}


#print the Error if file not present in exixting folder
function error_func(){
        echo -e "${notactive} 1. ip file is not present in exixting folder"
        echo -e "${notactive} 2. Check internet connectivity${NC}"
}


#Check if file is present or not...
if [ -e $file_path ];then
        file_check_ping_scan
else
        error_func
fi

exit
