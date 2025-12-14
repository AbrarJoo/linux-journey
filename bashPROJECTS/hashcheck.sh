#!/bin/bash

echo "=========FILE HASHES========="
for file in /etc/passwd /etc/shadow; do
	sudo md5sum $file
done
