#!/bin/bash
cloud=$1
file=$2

# Check if any cli is missing and if it is then install it. 
for app in aws az; do

    if ! command -v "$app" &> /dev/null ; then
        echo "Missing $app CLI. Please install it before continuing."
        exit 1
    fi
done

# Choose cloud platform
if [ -z $cloud ]; then
    echo 'Please enter which cloud provider you are using. AWS or Azure?'
    exit 1
fi
# Setup & Authentication:

# AWS
if [[ $cloud == 'aws' ]]; then
    aws(){
        if [ ! -f $HOME/.aws/credentials ]; then
            echo 'Please create credentials for AWS'
            exit 1
        fi
        echo 'creds exist'
    }

# Azure
elif [[ $cloud == 'az' ]]; then

    azure(){
        az login
    }

else
    echo 'please run again using aws or az'
fi

# CLI Argument Parsing

# File Check

# File Upload