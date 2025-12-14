#! /bin/bash
awk '/Failed password/ {fail++} /Accepted password/ {success++} END {print "failed:",fail,"success:",success}' /var/log/auth.log
