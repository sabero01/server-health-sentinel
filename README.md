# 🛡️ Server Health Sentinel

This isn't just a script. It's a statement.

> It's about the difference between being a **"Software Developer"** and being a **"Power User"** or **"Automator"**. A developer builds the car. A power user tunes it, drives it masterfully, and builds their own custom gauges for the dashboard.

This script is one of those gauges. It was born not from a desire to "program," but from a practical need to answer a simple, critical question: **"Is my server okay?"**

The Health Sentinel is a simple, lightweight, and powerful Bash script that acts as a watchdog for your Linux server. It monitors your system's vital signs and sends you an instant alert on Discord the moment something goes wrong.

## ✨ Features

*   **Monitors System Vitals:** CPU, RAM, and Disk usage.
*   **Configurable Thresholds:** You decide what's normal for your system.
*   **Instant Discord Alerts:** Get notified immediately via webhooks.
*   **Pure & Lightweight:** Written in pure Bash, requiring only `curl`. It's fast, portable, and has virtually no overhead.

##  Prerequisites

This script speaks the native language of Linux. Before you begin, ensure you have:

*   **A Linux Server:** With `Bash` (it's already there).
*   **`curl`:** The command-line tool for making web requests. If it's not installed, run: `sudo apt update && sudo apt install curl`
*   **A Discord Account:** To create a webhook for receiving alerts.

## 🚀 Setup & Configuration

Follow these steps to unleash your sentinel.

### 1. Make the Script Executable
Your sentinel needs permission to run. Give it with this command:
```bash
chmod +x health_monitor.sh
```

### 2. Configure the Sentinel
Open `health_monitor.sh` in your favorite text editor. The configuration variables are at the top.

*   `CPU_THRESHOLD`, `RAM_THRESHOLD`, `DISK_THRESHOLD`: Set the percentage values that you consider to be "high usage."
*   `WEBHOOK_URL`: This is the most important part. Paste your secret Discord webhook URL here.

> **🔒 Security First:** Your webhook URL is a secret, like a password. Never share it or commit it to a public repository.

### 3. Run a Manual Test
Test your sentinel to make sure it's working correctly.
```bash
./health_monitor.sh
```
You should see the current health stats printed to your console. To test the alerts, temporarily set a threshold to a very low number (e.g., `CPU_THRESHOLD=1`) and run it again. You should get an alert in your Discord channel.

##  automating="" the="" watchdog="">

A watchdog that isn't always watching is just a dog. The real power comes from automation. We'll use `cron` to run our script at regular intervals.

1.  Find the full path to your script by running `readlink -f health_monitor.sh`. Copy this path.
2.  Open your user's crontab file:
    ```bash
    crontab -e
    ```
3.  Add the following line at the bottom, replacing `/full/path/to/health_monitor.sh` with the path you copied.

    ```cron
    */5 * * * * /full/path/to/health_monitor.sh >/dev/null 2>&1
    ```
This command tells the system: "Every 5 minutes, run the Health Sentinel. I don't need to see the normal output (`>/dev/null 2>&1`), just send me an alert if something is wrong."

---

This script is a tool. But more than that, it's a first step. It's proof that you don't need a heavy framework or a complex application to have power over your digital domain. All you need is a shell, a good idea, and the will to automate.
