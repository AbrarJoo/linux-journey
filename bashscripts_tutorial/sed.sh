#!/bin/bash
echo "===== SYSTEM INFORMATION ====="
echo "Hostname: $(hostname)"
echo "OS: $(uname -o)"
echo "Kernel: $(uname -r)"
echo "CPU: $(lscpu | grep 'Model name')"
echo "Memory: $(free -h | grep Mem)"
echo "Disk Usage: $(df -h /)"

