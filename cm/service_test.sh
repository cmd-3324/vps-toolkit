#!/bin/bash
# You can add as amny services as You desire, But keep that in mind that it must match the exact name we have in Systemd.
# Wanna see exact name ? Run command : ps aux | grep -i "*name*"  to find the matching cases , Then Add it into varbile "services" . 
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
