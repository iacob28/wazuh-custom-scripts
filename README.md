# Wazuh Alert Reprocessing Script for Jira Integration

This script automates the extraction and reprocessing of Wazuh alerts with a specific `location` parameter for custom integrations, specifically targeting Jira. It’s designed for use with Wazuh in a Docker environment and enables users to create Jira tickets for selected alerts.

## 🛠️ Script Features

1. **Extract Alerts Based on Location**: Filters alerts from `alerts.json` where `location` is set to `"vulnerability-detector"`.
2. **Creates Individual JSON Files**: Saves each filtered alert as a separate JSON file in the `/var/ossec/logs/alerts/alerts-to-reprocess` directory. Each file is named using the alert ID.
3. **Jira Ticket Creation**: Can create Jira tickets for each extracted alert by sending them to a Jira integration.
4. **Flexible Execution Options**: Choose to extract and process alerts, only extract alerts, or reprocess existing files for Jira tickets without re-extraction.
5. **Color-Coded Output**: Displays messages with color codes for easier monitoring.

## 🐳 Requirements

- **Wazuh Docker Environment**: This script is designed for use with Wazuh in a Docker setup and uses `docker exec` to interact with the Wazuh container.
- **Jira API Credentials**: Replace the placeholder credentials and URL in the script with your actual Jira API credentials and URL.

## 🚀 Usage

Run the script with one of the following options:

- `--create-jira-ticket`: Extracts alerts from `alerts.json`, saves them to files, and creates Jira tickets.
- `--no-jira-ticket`: Only extracts alerts to files in the specified directory without creating Jira tickets.
- `--only-jira-ticket`: Skips alert extraction and processes existing files in the output directory for Jira ticket creation.
- `--help`: Displays usage instructions.

### Examples

1. **Extract Alerts and Create Jira Tickets**

   ```bash
   ./script.sh --create-jira-ticket
   ```

   This will extract alerts and create Jira tickets for each extracted alert.

2. **Extract Alerts Without Creating Jira Tickets**

   ```bash
   ./script.sh --no-jira-ticket
   ```

   This will only extract alerts and save them as JSON files in `/var/ossec/logs/alerts/alerts-to-reprocess`, without creating any Jira tickets.

3. **Reprocess Existing Files for Jira Tickets**

   ```bash
   ./script.sh --only-jira-ticket
   ```

   This skips the extraction process and directly processes all existing files in `/var/ossec/logs/alerts/alerts-to-reprocess` to create Jira tickets.

4. **Display Help**
   ```bash
   ./script.sh --help
   ```
   Shows usage information and available options.

## 🔗 How This Script Can Help

This script streamlines alert management and integration with Jira by:

- **Automating Incident Tracking**: Automatically creates Jira tickets for selected Wazuh alerts, making it easy to track and manage vulnerabilities.
- **Organizing Alerts for Reprocessing**: Each alert is saved individually, allowing for flexible reprocessing, analysis, or integration with other tools.
- **Customizable Integration**: This script is designed with flexibility in mind; you can easily adjust the `docker exec` command or modify integration parameters as needed.

### Additional Notes

- Ensure `jq` is installed on your system to enable JSON filtering.
- Update the Jira credentials (`user@example.com:your_api_token`) and URL (`https://example.atlassian.net`) in the script with your actual credentials.
- Make sure Docker is running and the Wazuh container (`single-node-wazuh.manager-1` in this example) is available.

Enjoy simplified alert processing and Jira integration! Let us know if you have questions or suggestions for improvement.

---
