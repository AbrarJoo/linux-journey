#! /bin/bash

echo "======WORLD READABLE FILES======="
find / -type f -perm -004 2>/dev/null
echo "========WORLD WRITABLE FILES======"
find / -type f -perm -002 2>/dev/null
