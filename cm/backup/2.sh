#!/bin/bash
user=$(whoami)
systemLogs="/home/$user/health_logs.log"
check_disk() {
    usage=$(df -h / | tail -1 | awk '{print $5}' | tr -d '%')
    if [ "$usage" -gt 80 ]; then
        echo "$(date)-$user ⚠️ DISK WARNING: ${usage}% used" | tee -a "$systemLogs"
    else
        echo "$(date)-$user ✅ Disk OK: ${usage}%" | tee -a "$systemLogs"
    fi
}