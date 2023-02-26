HOSTNAME=$(hostname)
DATE=$(date "+%Y-%m-%d %H:%M:%S")
CPUSAGE=$(top -b -n 1 -d1 | grep "Cpu" | awl '{print $2}' | awk -F. '{print $1}')
MEMUSAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
DISKUSAGE=$(df -P | column -t | awk '{print $5}' | tail -n 1 | sed 's/%//g')
echo 'HOSTNAME, DATE&TIME, CPUI(%), MEM(%), DISK(%)' 
echo "$HOSTNAME, $DATE, $CPUSAGE, $MEMUSAGE, $DISKUSAGE"