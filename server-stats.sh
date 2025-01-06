#!/bin/bash

# Professional Bash Script for Server Performance Stats

# Function to display total CPU usage
display_cpu_usage() {
    echo -e "\n[CPU Usage]"
    top -bn1 | grep "Cpu(s)" | awk '{print "User: "$2"% System: "$4"% Idle: "$8"%"}'
}

# Function to display total memory usage
display_memory_usage() {
    echo -e "\n[Memory Usage]"
    free -m | awk 'NR==2{printf "Used: %sMB Free: %sMB (%.2f%% used)\n", $3, $4, $3*100/$2 }'
}

# Function to display total disk usage
display_disk_usage() {
    echo -e "\n[Disk Usage]"
    df -h --total | grep total | awk '{printf "Used: %s Free: %s (%s used)\n", $3, $4, $5}'
}

# Function to display top 5 processes by CPU usage
display_top_cpu_processes() {
    echo -e "\n[Top 5 Processes by CPU Usage]"
    ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6 | awk 'NR==1{printf "%-10s %-20s %-10s\n", "PID", "Command", "CPU (%)"}; NR>1{printf "%-10s %-20s %-10s\n", $1, $2, $3}'
}

# Function to display top 5 processes by memory usage
display_top_memory_processes() {
    echo -e "\n[Top 5 Processes by Memory Usage]"
    ps -eo pid,comm,%mem --sort=-%mem | head -n 6 | awk 'NR==1{printf "%-10s %-20s %-10s\n", "PID", "Command", "Memory (%)"}; NR>1{printf "%-10s %-20s %-10s\n", $1, $2, $3}'
}

# Main script execution
echo "======================== Server Performance Stats ========================"
display_cpu_usage
display_memory_usage
display_disk_usage
display_top_cpu_processes
display_top_memory_processes
echo "==========================================================================="
