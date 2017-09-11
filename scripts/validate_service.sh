#!/bin/bash
# passing condition is that healthy count equal to healthy_threshold
host=$1
healthy=1
unhealthy=1

retries=20
healthy_threshold=5
unhealthy_threshold=5
interval=3

function healthcheck {
  status=$(curl -s -o /dev/null -w "%{http_code}" $host)
}

function healthy_log {
  echo "[$1] connected: healthy count ($2/$3) (left over $4)"
}

function unhealthy_log {
  echo "[$1] disconnected: unhealthy count ($2/$3) (left over $4)"
}

while [ $retries -gt 0 ]
do
  healthcheck

  if [ $status -eq 200 ]; then
    if [ $healthy -eq $healthy_threshold ]; then
      healthy_log $status $healthy $healthy_threshold $retries

      exit 0
    else
      healthy_log $status $healthy $healthy_threshold $retries

      ((healthy++))
      ((retries--))
      sleep $interval
    fi
  else
    unhealthy_log $status $unhealthy $unhealthy_threshold $retries

    ((unhealthy++))
    ((retries--))
    sleep $interval
  fi
done
  echo "timeouted"
  exit 1