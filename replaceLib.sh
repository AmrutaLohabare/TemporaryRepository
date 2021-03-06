#!/bin/bash

did="$(docker ps -q)"
echo "${did}"

#Stop the IS
echo ""
echo "[INFO]:Stop the IS..."
echo "" 
docker exec -u aruser ${did} bash /opt/bmc/ars/arsystem/bin/arsystem stop
sleep 50

#Rename the  existing lib
echo ""
echo "[INFO]:Rename the existing Jar... "
echo ""
docker exec ${did} bash -c 'mv /opt/bmc/ars/arsystem/lib /opt/bmc/ars/arsystem/lib_ori${RANDOM}' 

#Copy the New Jar to exact location
echo ""
echo "[INFO]:Copy the Jar to exact location..."
echo ""
docker cp `pwd`/lib ${did}:/opt/bmc/ars/arsystem/

#Give aruser permission to lib

docker exec ${did} bash -c 'chmod -R 777 /opt/bmc/ars/arsystem/lib/start/startlevel7/'
docker exec ${did} bash -c 'chown -R aruser:aruser /opt/bmc/ars/arsystem/lib/'

#Remove the bundle cache
echo ""
echo "[INFO]:Removing the bundle cache..."
echo ""
docker exec ${did} bash -c 'rm -rf /opt/bmc/ars/arsystem/bundle-cache'

#Restart the docker container
echo ""
echo "[INFO]:Restart the docker container..."
echo ""

docker stop ${did} 
docker start ${did}

#Check the status of IS
echo ""
echo "[INFO]:Check the IS status..."
echo ""

file="/data1/isdata/db/docker-deploy.log"
sleep 10
tail -f $file | while read LINE
do
echo "$LINE"
   if [[ "$LINE" == *"Innovation Suite Server Ready"* || "$LINE" == *"ERROR:"* || "$LINE" == *"Innovation Suite Server failed to start"* ]]; then
                if [[ "$LINE" == *"Innovation Suite Server Ready"* ]]; then
                kill $(ps aux | grep 'docker-deploy' | grep -v grep |awk '{print $2}')
                elif [[ "$LINE" == *"Innovation Suite Server failed to start"* ]]; then
                echo "ERROR Found in docker-deploy.log, $LINE"
                kill $(ps aux | grep 'docker-deploy' | grep -v grep |awk '{print $2}')
                exit 200
                else
                echo "IS failed to start, $LINE"
                kill $(ps aux | grep 'docker-deploy' | grep -v grep |awk '{print $2}')
                exit 200
                fi
   fi
done

