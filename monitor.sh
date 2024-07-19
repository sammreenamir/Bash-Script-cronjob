#!/bin/bash

# Log file location
LOG_FILE="/var/log/system_monitor.log"

# Get the current timestamp
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# Get CPU usage
CPU_USAGE=$(top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}')

# Get detailed RAM usage
RAM_USED=$(free -h | awk '/Mem:/ {print $3}')
RAM_TOTAL=$(free -h | awk '/Mem:/ {print $2}')
RAM_FREE=$(free -h | awk '/Mem:/ {print $4}')

# Get root filesystem usage
ROOT_USED=$(df -h / | awk 'NR==2 {print $3}')
ROOT_TOTAL=$(df -h / | awk 'NR==2 {print $2}')
ROOT_AVAILABLE=$(df -h / | awk 'NR==2 {print $4}')

# Write the output to the log file
echo "$TIMESTAMP, CPU Usage: $CPU_USAGE%, RAM Usage: Used: $RAM_USED, Total: $RAM_TOTAL, Free: $RAM_FREE, Root Usage: Used: $ROOT_USED, Total: $ROOT_TOTAL, Available: $ROOT_AVAILABLE" >> $LOG_FILE