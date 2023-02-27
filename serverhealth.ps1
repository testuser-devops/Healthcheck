#!/bin/bash
for i in hostlist;
do
  Get-ServerHealth -Identity $i >>serverhealth
  HOSTNAME=$( ssh $i hostname)
  DATE=$( ssh $i date "+%Y-%m-%d %H:%M:%S")
  CPUSAGE=$(ssh $i top -b -n 1 -d1 | grep "Cpu" | awl '{print $2}' | awk -F. '{print $1}')
  MEMUSAGE=$(ssh $i free | grep Mem | awk '{print $3/$2 * 100.0}')
  DISKUSAGE=$(ssh $i df -P | column -t | awk '{print $5}' | tail -n 1 | sed 's/%//g')
  SERVERLIST=$(ssh $i Get-Process | Where-Object {$_.CPU -gt 1}) >>processlist
  echo 'HOSTNAME, DATE&TIME, CPUI(%), MEM(%), DISK(%)' >>usagereport
  echo "$HOSTNAME, $DATE, $CPUSAGE, $MEMUSAGE, $DISKUSAGE" >>usagereport
done
