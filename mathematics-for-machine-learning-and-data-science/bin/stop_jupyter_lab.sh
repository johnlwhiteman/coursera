#!/usr/bin/env bash

echo "Stopping all jupyter lab instances if running"

PORTS=$(jupyter lab list | grep "http" | awk -F ":" '{print $3}' | awk -F "/" '{print $1}')

# Iterate over the list
for port in $PORTS; do
    echo "Stopping jupyter lab: https://localhost/${port}"
    jupyter lab stop $port
done
