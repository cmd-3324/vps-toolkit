#!/bin/bash
# Run : chmod +x SysHealth.sh To be able to run script in Bash! 
clear

pause() {
    read -p "Press Enter to continue..."
    clear
}

show_system() {
    echo "========== SYSTEM =========="
    echo
    echo "Hostname: $(hostname)"
    echo "Kernel:   $(uname -r)"
    echo "Uptime:   $(uptime -p)"
    echo "Date:     $(date)"
}

show_cpu() {
    echo "========== CPU =========="
    echo
    echo "CPU Cores: $(nproc)"
    echo "Load:"
    uptime | awk -F'load average:' '{print $2}'
    echo
    echo "CPU:"
    top -bn1 | grep "Cpu(s)" | awk '{print "Usage: " 100 - $8 "%"}'
}

show_memory() {
    echo "========== MEMORY =========="
    echo
    free -h
}

show_disk() {
    echo "========== DISK =========="
    echo
    df -h --exclude="tmpfs" --exclude="devtmpfs"
}

show_services() {
    echo "========== SERVICES =========="
    echo

    services=("nginx" "postgresql" "redis")

    for service in "${services[@]}"; do
        if systemctl is-active --quiet "$service"; then
            echo "$service: RUNNING"
        else
            echo "$service: STOPPED"
        fi
    done
}

show_ports() {
    echo "========== PORTS =========="
    echo
    ss -tuln
}

while true; do
    clear

    echo "====== SYSTEM HEALTH MONITOR ======"
    echo
    echo "1. System Information"
    echo "2. CPU"
    echo "3. Memory"
    echo "4. Disk"
    echo "5. Services"
    echo "6. Ports"
    echo "7. Full Health Report"
    echo "8. Exit"
    echo

    read -p "Choose: " choice

    clear

    case "$choice" in
        1)
            show_system
            pause
            ;;

        2)
            show_cpu
            pause
            ;;

        3)
            show_memory
            pause
            ;;

        4)
            show_disk
            pause
            ;;

        5)
            show_services
            pause
            ;;

        6)
            show_ports
            pause
            ;;

        7)
            show_system
            echo
            show_cpu
            echo
            show_memory
            echo
            show_disk
            echo
            show_services
            echo
            show_ports
            pause
            ;;

        8)
            clear
            echo "Goodbye."
            break
            ;;

        *)
            echo "Invalid option."
            pause
            ;;
    esac
done
