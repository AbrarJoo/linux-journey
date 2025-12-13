#! /bin/bash
echo "======NON ROOT PROCESSES========"
ps aux | awk '$1 != "root" {print $0}'
