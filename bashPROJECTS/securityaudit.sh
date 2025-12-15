#!/bin/bash
echo "===== SYSTEM INFO ====="
uname -a
echo "===== USERS ====="
cut -d: -f1 /etc/passwd
echo "===== SUDO USERS ====="
getent group sudo
echo "===== WORLD-WRITABLE FILES ====="
find / -type f -perm -002 2>/dev/null
echo "===== FAILED LOGINS ====="
grep "Failed password" /var/log/auth.log | tail -n 10
echo "===== OPEN PORTS ====="
for port in {20..1024}; do
  timeout 1 bash -c "echo > /dev/tcp/127.0.0.1/$port" 2>/dev/null && echo "Port $port is open"
done
