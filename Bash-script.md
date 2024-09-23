# Task: Run Bash file via cron job 
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
./monitor.sh

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
*/2 * * * * /home/samreen_desktop/monitor.sh
```

Replace /path/to/system_monitor.sh with the actual path to the script.

### 10- Verify cron job execution
```sh
cat /var/log/system_monitor.log
```

## conclusion:
By following these steps, You will have a monitoring script that logs system resource usage every 2 minutes.


## output:
```sh
2024-09-23 07:04:27, CPU Usage: 18.7%, RAM Usage: Used: 606Mi, Total: 1.8Gi, Free: 272Mi, Root Usage: Used: 3.0G, Total: 1007G, Available: 953G
2024-09-23 07:06:01, CPU Usage: 14.3%, RAM Usage: Used: 603Mi, Total: 1.8Gi, Free: 274Mi, Root Usage: Used: 3.0G, Total: 1007G, Available: 953G
2024-09-23 07:08:01, CPU Usage: 6.2%, RAM Usage: Used: 605Mi, Total: 1.8Gi, Free: 273Mi, Root Usage: Used: 3.0G, Total: 1007G, Available: 953G
2024-09-23 07:10:01, CPU Usage: 14.7%, RAM Usage: Used: 604Mi, Total: 1.8Gi, Free: 273Mi, Root Usage: Used: 3.0G, Total: 1007G, Available: 953G
```
