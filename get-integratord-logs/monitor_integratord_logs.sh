#!/bin/bash

# Default values for variables, which can be overridden by environment variables or script arguments
LOGFILE="${LOGFILE:-/path/to/logfile.log}"
OUTPUTFILE="${OUTPUTFILE:-/path/to/outputfile.log}"
PATTERN="${PATTERN:-error}"

# Check if the log file exists
if [[ ! -f "$LOGFILE" ]]; then
    echo "Log file '$LOGFILE' not found!"
    exit 1
fi

# Check if the output file is writable
if [[ ! -w "$(dirname "$OUTPUTFILE")" ]]; then
    echo "Output file directory is not writable!"
    exit 1
fi

# Function to start monitoring the log
monitor_log() {
    echo "Monitoring '$LOGFILE' for pattern '$PATTERN'. Output will be saved to '$OUTPUTFILE'."
    tail -f "$LOGFILE" | grep --line-buffered "$PATTERN" >>"$OUTPUTFILE"
}

# Call the monitoring function
monitor_log
