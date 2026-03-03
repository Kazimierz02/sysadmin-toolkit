#!/bin/bash

if [ "$#" -ne 1 ]; then
    exit 1
fi

if [ ! -f "$1" ]; then
    exit 1
fi

grep -a "Failed password" "$1" | grep -oP '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | sort | uniq -c | sort -nr | while read count ip; do
    if [ "$count" -ge 5 ]; then
        printf "WARNING: %-15s | Failed attempts: %d\n" "$ip" "$count"
    fi
done
