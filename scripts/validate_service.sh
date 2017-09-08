#!/bin/bash

result=$(curl -s http://localhost:3000/hello)
if [[ "$result" =~ "world" ]]; then
  exit 0
else
  exit 1
fi