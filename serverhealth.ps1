#!/bin/bash
echo "server status"
for i in hostlist;
do
  SERHEALTH=$(Get-ServerHealth -Identity $i) 
  HOSTNAME=$( ssh $i hostname)
  DATE=$( ssh $i date "+%Y-%m-%d %H:%M:%S")
  CPUSAGE=$(ssh $i top -b -n 1 -d1 | grep "Cpu" | awl '{print $2}' | awk -F. '{print $1}')
  MEMUSAGE=$(ssh $i free | grep Mem | awk '{print $3/$2 * 100.0}')
  DISKUSAGE=$(ssh $i df -P | column -t | awk '{print $5}' | tail -n 1 | sed 's/%//g')
  PROCLIST=$(ssh $i Get-Process | Where-Object {$_.CPU -gt 1}) 
  APPSTATUS=$(ssh $i Get-Service |
  Where-Object {
    ($_.DisplayName -EQ "java") -or ($_.DisplayName -EQ "docker")
  })
  IISSITEST=$(ssh $i Get-IISSite)
  echo 'server health'>>usagereport
  echo "$SERHEALTH">>usagereport
  echo 'HOSTNAME, DATE&TIME, CPUI(%), MEM(%), DISK(%)' >>usagereport
  echo "$HOSTNAME, $DATE, $CPUSAGE, $MEMUSAGE, $DISKUSAGE" >>usagereport
  echo 'PROCLIST'>>processlist
  echo "$PROCLIST">>processlist
  echo 'APPSTATUS'>>usagereport
  echo "$APPSTATUS">>usagereport
  echo 'IISSITEST'>>usagereport
  echo "$IISSITEST">>usagereport

  done
