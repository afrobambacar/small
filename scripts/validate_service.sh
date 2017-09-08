#!/bin/bash

counter=1
retries=5
interval=3

function healthcheck {
  status=$(curl -s -o /dev/null -w "%{http_code}" http://localhost)
}

while [ $counter -lt $retries ]
do
  healthcheck
  if [ $status -eq 200 ]; then
    echo "connected $status"
    exit 0
  else
    echo "disconnected $counter $status"
    sleep $interval
    ((counter++))
  fi
done
  echo "timeouted"
  exit 1