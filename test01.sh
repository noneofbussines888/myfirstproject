#!/bin/bash

# Script to analyze basic server performance stats

# Function to display CPU usage
display_cpu_usage() {
    echo "\nTotal CPU Usage:"
    top -bn1 | grep "Cpu(s)" | \
    awk '{print "User: "$2"% System: "$4"% Idle: "$8"%"}'
}

# Function to display memory usage
display_memory_usage() {
    echo "\nTotal Memory Usage:"
    free -m | awk 'NR==2{printf "Used: %sMB Free: %sMB (%.2f%% used)\n", $3, $4, $3*100/$2 }'
}

# Function to display disk usage
display_disk_usage() {
    echo "\nTotal Disk Usage:"
    df -h --total | grep total | \
    awk '{printf "Used: %s Free: %s (%s used)\n", $3, $4, $5}'
}

# Function to display top 5 processes by CPU usage
display_top_cpu_processes() {
    echo "\nTop 5 Processes by CPU Usage:"
    ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
}

# Function to display top 5 processes by memory usage
display_top_memory_processes() {
    echo "\nTop 5 Processes by Memory Usage:"
    ps -eo pid,comm,%mem --sort=-%mem | head -n 6
}

# Main script execution
echo -e "--- Server Performance Stats ---"
echo -e "\nTotal CPU Usage:"
display_cpu_usage
echo -e "\nTotal Memory Usage:"
display_memory_usage
echo -e "\nTotal Disk Usage:"
display_disk_usage
echo -e "\nTop 5 Processes by CPU Usage:"
display_top_cpu_processes
echo -e "\nTop 5 Processes by Memory Usage:"
display_top_memory_processes

