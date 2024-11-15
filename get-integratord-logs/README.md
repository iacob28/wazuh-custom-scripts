# Wazuh Log Extraction and Monitoring Script

## Overview

This script is designed to extract specific logs from the `ossec.log` file and monitor the extracted logs in real-time. It is primarily used to filter and track integrator logs, and to display the relevant information in the Wazuh dashboard using the Wazuh agent installed on the manager server.

The script is modular, so it can be used to extract any information from the `ossec.log` file based on custom patterns. It runs continuously, monitoring the log file for updates and filtering logs into an output file. The output file can be monitored directly on the Wazuh dashboard, making it easier to detect and respond to security events in real time.

## Features

- **Real-time Log Monitoring**: The script continuously monitors the `ossec.log` file for new entries that match a specified pattern.
- **Customizable Log Filtering**: You can specify the log pattern to search for, such as "error", "warning", or any custom keyword.
- **Wazuh Dashboard Integration**: The filtered logs are saved to an output file, which is monitored on the Wazuh dashboard using the Wazuh agent installed on the manager server.
- **Flexible Configuration**: The script accepts parameters like the log file location, output file, and pattern, making it adaptable for different use cases.

## Prerequisites

- A running **Wazuh Manager** with the **Wazuh Agent** installed on the server.
- The script should have read access to the `ossec.log` file on the Wazuh Manager server.
- The script requires a writable directory for the output log file.

## Installation

1. Clone this repository to your local machine:

   ```bash
   git clone this repo
   get the files from the get-integratord-logs directory
   ```

2. Make the script executable:

   ```bash
   chmod +x monitor_log.sh
   ```

3. (Optional) Configure the log file, output file, and pattern via environment variables or a configuration file:

   ```bash
   LOGFILE="/path/to/ossec.log"
   OUTPUTFILE="/path/to/outputfile.log"
   PATTERN="error"
   ```

   Alternatively, you can use the provided `config.env` file to set these variables.

## Usage

### Run the Script Manually

To run the script manually, use the following command:

```bash
LOGFILE="/path/to/ossec.log" OUTPUTFILE="/path/to/outputfile.log" PATTERN="error" ./monitor_log.sh
```

This will start the script, monitor the `ossec.log` file for entries matching the pattern `error`, and append the filtered results to `outputfile.log`.

### Running the Script as a Service

To ensure the script runs continuously in the background, you can set it up as a `systemd` service.

1. Create a `systemd` service file at `/etc/systemd/system/monitor-log.service`:

   ```ini
   [Unit]
   Description=Monitor Log and Filter Errors

   [Service]
   ExecStart=/path/to/monitor_log.sh
   Restart=always
   User=your_user
   Group=your_group
   EnvironmentFile=/path/to/config.env
   StandardOutput=syslog
   StandardError=syslog

   [Install]
   WantedBy=multi-user.target
   ```

2. Reload `systemd` and enable the service:

   ```bash
   sudo systemctl daemon-reload
   sudo systemctl enable monitor-log.service
   sudo systemctl start monitor-log.service
   ```

3. Monitor the service:

   ```bash
   sudo systemctl status monitor-log.service
   sudo journalctl -u monitor-log.service
   ```

### Viewing Logs in Wazuh Dashboard

Once the script is running, the output file specified in the `OUTPUTFILE` parameter will be continuously updated with the filtered logs. These logs can be monitored directly in the Wazuh dashboard for further analysis and response.

## Configuration

The following environment variables can be configured:

- `LOGFILE`: The path to the `ossec.log` file (default: `/path/to/ossec.log`).
- `OUTPUTFILE`: The path to the output file where filtered logs will be saved (default: `/path/to/outputfile.log`).
- `PATTERN`: The pattern to search for in the log file (default: `"error"`).

You can configure these variables by editing the `config.env` file or by setting them inline when running the script.
