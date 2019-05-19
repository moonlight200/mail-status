#!/bin/bash
recipient=$1

# Create temporary file
tmpFile=$(mktemp)

echo "Status report created at $(date)" > $tmpFile

echo -e "\n[General Info]" >> $tmpFile
echo "Hostname: $(hostname)" >> $tmpFile
echo "OS type: $(cat /proc/sys/kernel/ostype)" >> $tmpFile
echo "Kernel version: $(cat /proc/sys/kernel/osrelease)" >> $tmpFile
echo "System uptime: $(uptime)" >> $tmpFile

echo -e "\n[IPs]" >> $tmpFile
echo "$(ip addr show scope global | grep inet | cut -d' ' -f6 | cut -d/ -f1)" >> $tmpFile

echo -e "\n[RAM usage]" >> $tmpFile
free -h >> $tmpFile

echo -e "\n[Mounted disks]" >> $tmpFile
df -h >> $tmpFile

echo -e "\n[Available updates]" >> $tmpFile
apt update
apt list --upgradable >> $tmpFile

echo -e "\n[Services]" >> $tmpFile
netstat -tulpn >> $tmpFile 2>&1

echo -e "\n[Running Processes]" >> $tmpFile
top -bn 1 >> $tmpFile

# Send email
mail -a"From: $(whoami)@$(hostname)" -s "Status report for: $(hostname)" $recipient <$tmpFile
rm $tmpFile
