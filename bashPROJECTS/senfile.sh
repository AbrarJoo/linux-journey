#! /bin/bash
echo "=======sensitive files folder======="
for file in /etc/passwd /etc/shadow; do
	[ -f "$file" ] && ls -l "$file"
done

echo "===========HIDDEN FILES========="
find ~ -type f -name ".*"
