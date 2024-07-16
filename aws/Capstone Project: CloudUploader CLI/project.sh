#!/bin/bash

# Check if any cli is missing and if it is then install it. 
for app in aws az; do
    $app --version &> /dev/null
    if [ $? -gt 0 ]; then
        echo -e "Missing $app cli... please install before continuing"
        exit 1
    fi
done