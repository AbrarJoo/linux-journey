#! /bin/bash
echo "=========DIRECTORY SNAPSHOT========"
sudo find /etc -type f -exec md5sum {} \; > /tmp/etc_snapshot.md5
