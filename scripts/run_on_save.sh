#!/bin/bash
file="$1" # Name of file
command="${*:2}" # Command to run on change (takes rest of line)
t1="$(ls --full-time $file | awk '{ print $7 }')" # Get latest save time
while true
do
  t2="$(ls --full-time $file | awk '{ print $7 }')" # Compare to new save time
  if [ "$t1" != "$t2" ];then t1="$t2"; $command; fi # If different, run command
  sleep 0.5
done
