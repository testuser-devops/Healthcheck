
for i in hostlist;
do
HOSTNAME=$( ssh $i hostname)
DATE=$( ssh $i date "+%Y-%m-%d %H:%M:%S")
CPUSAGE=$(ssh $i top -b -n 1 -d1 | grep "Cpu" | awl '{print $2}' | awk -F. '{print $1}')
MEMUSAGE=$(ssh $i free | grep Mem | awk '{print $3/$2 * 100.0}')
DISKUSAGE=$(ssh $i df -P | column -t | awk '{print $5}' | tail -n 1 | sed 's/%//g')
echo 'HOSTNAME, DATE&TIME, CPUI(%), MEM(%), DISK(%)' >>usagereport
echo "$HOSTNAME, $DATE, $CPUSAGE, $MEMUSAGE, $DISKUSAGE" >>usagereport
done