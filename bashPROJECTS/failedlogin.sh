#! /bin/bash
echo "==========FAILED LOGIN DETECTOR========="
grep -i "failed password" /var/log/auth.log | tail -n 10
