# Task: Run Bash file via cron job 
## Team Member : Sammreen Amir, Zeeshan Riaz

A bash script to monitor and log CPU, RAM, and storage usage on a Linux system. The script logs data with timestamps and can be scheduled to run periodically using cron.

## Features

- **CPU Usage Monitoring**: Monitors the percentage of CPU usage.
- **RAM Usage Monitoring**: Monitors the amount of RAM used, total, and free.
- **Storage Usage Monitoring**: Monitors the storage usage of the root (`/`) filesystem.
- **Logging**: Logs the system usage data to `/var/log/system_monitor.log` with timestamps.
- **Cron Job Scheduling**: Can be set up to run periodically using a cron job.

## Requirements

- A Linux system with `bash`.
- `sysstat` package (for the `mpstat` command).

## 1-Install Dependencies

Install the necessary dependencies:

```sh
sudo yum install sysstat
```

### 2-Create a new Bash script file

```sh
 vi monitor.sh
```

### 3- Add bash script to the file 

#### Note:This is the script to display the  CPU usage, RAM usage as a percentage, and root filesystem usage as a percentage.
```sh
#!/bin/bash

# Log file location
LOG_FILE="/var/log/system_monitor.log"

# Get the current timestamp
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# Get CPU usage
CPU_USAGE=$(top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}')

# Get RAM usage
RAM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')

# Get root filesystem usage
ROOT_USAGE=$(df -h / | grep / | awk '{ print $5 }')

# Write the output to the log file
echo "$TIMESTAMP, CPU Usage: $CPU_USAGE%, RAM Usage: $RAM_USAGE%, Root Usage: $ROOT_USAGE" >> $LOG_FILE
```
#### Note:This bash script is used to display the cpu information total memory usage memory and free memory of ram and root storage
```sh
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

```



### 4-  Make the Script Executable

Make the script executable:

```sh
chmod +x system_monitor.sh
or 
chmod +x monitor.sh

```

### 5- Setup Log Directory and Permissions

Ensure the log directory exists and set the appropriate permissions
```sh
sudo mkdir -p /var/log
sudo touch /var/log/system_monitor.log
sudo chmod 666 /var/log/system_monitor.log
```


## Note:Run the script manually to see the output:
```sh
./system_monitor.sh
```

### 6- Install Chron
```sh
sudo yum install cronie
sudo systemctl start crond
sudo systemctl enable crond
sudo systemctl status crond
```

## 7- Schedule the script with  cron

To run the script every 2 minutes, follow these steps:

### 8. Open the Crontab Editor

Open the crontab editor:

```sh
crontab -e
```

### 9. Add the Cron Job

Add the following line to run the script every 2 minutes:

```sh
*/2 * * * * /root/monitor.sh
```

Replace /path/to/system_monitor.sh with the actual path to the script.

### 10- Verify cron job execution
```sh
cat /var/log/system_monitor.log
```

## conclusion:
By following these steps, You will have a monitoring script that logs system resource usage every 2 minutes.


## script 1 output:
```sh
2024-07-19 10:00:01, CPU Usage: 3.1%, RAM Usage: 18.8959%, Root Usage: 1%
2024-07-19 10:16:01, CPU Usage: 0%, RAM Usage: 18.7115%, Root Usage: 1%
2024-07-19 10:18:01, CPU Usage: 1.5%, RAM Usage: 18.8173%, Root Usage: 1%
2024-07-19 10:20:01, CPU Usage: 0%, RAM Usage: 18.9557%, Root Usage: 1%
2024-07-19 10:22:01, CPU Usage: 1.6%, RAM Usage: 18.9305%, Root Usage: 1%
2024-07-19 10:24:01, CPU Usage: 1.6%, RAM Usage: 19.0192%, Root Usage: 1%
```
## script 2 output:
```sh
2024-07-19 10:36:01, CPU Usage: 3.2%, RAM Usage: Used: 720Mi, Total: 3.8Gi, Free: 3.0Gi, Root Usage: Used: 3.4G, Total: 1007G, Available: 953G
2024-07-19 10:38:01, CPU Usage: 4.8%, RAM Usage: Used: 731Mi, Total: 3.8Gi, Free: 3.0Gi, Root Usage: Used: 3.4G, Total: 1007G, Available: 953G
2024-07-19 10:40:01, CPU Usage: 3.1%, RAM Usage: Used: 716Mi, Total: 3.8Gi, Free: 3.0Gi, Root Usage: Used: 3.4G, Total: 1007G, Available: 953G
2024-07-19 10:42:01, CPU Usage: 3%, RAM Usage: Used: 730Mi, Total: 3.8Gi, Free: 3.0Gi, Root Usage: Used: 3.4G, Total: 1007G, Available: 953G
```






