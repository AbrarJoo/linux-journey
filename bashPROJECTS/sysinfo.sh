#! /bin/bash
echo "=====SYSTEM-INFO====="
echo "HOSTNAME: $( hostname )"
echo "OS: $( uname -o )"
echo "KERNEL: $( uname -r )"
echo "CPU: $( lscpu | grep -i "model name" )"
echo "MEMORY: $( free -h | grep -i "total" )"
echo "DISK USAGE: $( df -h )"
echo "NETWORK INTERFACE: $( ip -br a )

