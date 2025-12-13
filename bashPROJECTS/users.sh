#! /bin/bash
echo "======USERS====="
cut -d: -f1 /etc/passwd

echo "======logins======"
last

echo "=======sudo users======="
getent group sudo
