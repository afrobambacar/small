#!/bin/bash

counter=1
retries=5
interval=3

function healthcheck {
  result=$(curl -s http://localhost:3000/hello)
}

while [ $counter -lt $retries ]
do
  healthcheck
  if [[ "$result" -eq "world" ]]; then
    echo "connected"
    exit 0
  else
    echo "disconnected $counter"
    sleep $interval
    ((counter++))
  fi
done
  echo "timeouted"
  exit 1