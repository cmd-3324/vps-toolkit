#!/bin/bash

services="nginx redis-server mysql"

for service in $services
do 
   if systemctl is-active --quiet "$service"; then 
	echo "Ok: $service"
   else	
	echo "$service : DOWN - Attempting restart "

	sudo systemctl restart "$service"
   fi
done
