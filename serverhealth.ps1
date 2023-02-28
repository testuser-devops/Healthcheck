#!/bin/bash
rm -r report
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
    (($_.DisplayName -EQ "java") -or ($_.DisplayName -EQ "docker"))
  })
  IISSITEST=$(ssh $i Get-IISSite)
  echo 'HOSTNAME'>>report
  echo "<-------$HOSTNAME------->">>report
  echo '<----------server health-------------->'>>report
  echo "$SERHEALTH">>report
  echo '<--------------Usage----------------->'>>report
  echo 'DATE&TIME, CPUI(%), MEM(%), DISK(%)' >>report
  echo "$HOSTNAME, $DATE, $CPUSAGE, $MEMUSAGE, $DISKUSAGE" >>report
  echo '<----------PROCLIST------------>'>>report
  echo "$PROCLIST">>report
  echo '<----APPSTATUS-------->'>>report
  echo "$APPSTATUS">>report
  echo '<-------------IISSITEST----------->'>>report
  echo "$IISSITEST">>report
  echo '<------------------------------------------------------------------------------------->'

done
