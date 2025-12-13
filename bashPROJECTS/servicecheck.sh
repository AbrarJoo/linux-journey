#! /bin/bash

echo "=======ACTIVE SERVICES======="
systemctl list-units --type=service --state=running
