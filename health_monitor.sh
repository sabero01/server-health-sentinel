#!/bin/bash

# --- Configuration ---
# Set the thresholds (as whole numbers) for CPU, RAM, and Disk usage.
# The script will send an alert if any of these are exceeded.
CPU_THRESHOLD=80
RAM_THRESHOLD=80
DISK_THRESHOLD=85

# --- IMPORTANT ---
# Paste your new, secret Discord webhook URL here.
# Do not share this URL or commit it to a public repository.
WEBHOOK_URL="PASTE_YOUR_NEW_SECRET_URL_HERE"    

# --- Logic ---
# Get current usage stats. These commands parse the output of standard linux tools.

# CPU Usage: Uses top to get a snapshot, finds the 'idle' percentage, and subtracts from 100.
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}' | cut -d. -f1)

# RAM Usage: Uses free to calculate the percentage of used memory.
RAM_USAGE=$(free -m | awk 'NR==2{printf "%.0f", $3/$2*100}')

# Disk Usage: Uses df to get the usage for the root partition '/' and removes the '%' sign.
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

# Function to send a notification to the Discord webhook.
# It takes one argument: the message to be sent.
send_alert() {
  local MESSAGE=$1
  echo "Sending alert: $MESSAGE"
  curl -H "Content-Type: application/json" -X POST -d "{"content":"🚨 Server Alert: $MESSAGE 🚨"}" $WEBHOOK_URL
}

# --- Checks ---
# Compare current usage with the thresholds and call the alert function if exceeded.

echo "Checking system health..."
echo "CPU: ${CPU_USAGE}% | RAM: ${RAM_USAGE}% | Disk: ${DISK_USAGE}%"

if [ $CPU_USAGE -gt $CPU_THRESHOLD ]; then
  send_alert "CPU usage is high: ${CPU_USAGE}%"
fi

if [ $RAM_USAGE -gt $RAM_THRESHOLD ]; then
  send_alert "RAM usage is high: ${RAM_USAGE}%"
fi

if [ $DISK_USAGE -gt $DISK_THRESHOLD ]; then
  send_alert "Disk usage is high: ${DISK_USAGE}%"
fi

echo "Health check complete."
