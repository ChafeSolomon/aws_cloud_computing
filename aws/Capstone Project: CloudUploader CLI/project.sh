#!/bin/bash
set -e

cloud=$1
file=$2
location_file=/home/$USER/.cloud_upload

# Check if any cli is missing and if it is then install it. 
for app in aws az sed; do

    if ! command -v "$app" &> /dev/null ; then
        echo "Missing $app CLI. Please install it before continuing."
        exit 1
    fi
done

# Choose cloud platform
if [[ -z $cloud ]]; then
    echo 'Please enter which cloud provider you are using. AWS or Azure?'
    exit 1
fi

# Choose s3 location
if [[ ! -f $location_file ]]; then
    read -p 'What is the s3 location to place all files? ' aws_location
    echo $aws_location
    echo -e "aws_location=$aws_location" > $location_file
    read -p 'What is the storage account location to place all files? ' az_location
    echo $az_location
    echo -e "az_location=$aws_location" >> $location_file
    for param in accountname accountkey sharename path; do
        read -p "For Azure set up... Please input $param " $param
    done
    echo -e "az-account-name=$accountname" >> $location_file
    echo -e "az-account-key=$accountkey" >> $location_file
    echo -e "az-share-name=$sharename" >> $location_file
    echo -e "az-path=$path" >> $location_file
fi
# Setup & Authentication:

# AWS
if [[ $cloud == 'aws' ]]; then
    aws(){
        if [ ! -f $HOME/.aws/credentials ]; then
            echo 'Please create credentials for AWS'
            exit 1
        elif [[ -z $file ]]; then
            echo 'Please specify file location'
            exit 1
        fi

        fileuploadname=$(basename $file)
        aws_location=$(sed -n 's/^aws_location=\(.*\)/\1/p' $location_file)
        aws s3 cp "$file" "$aws_location/$fileuploadname"
    }
    aws
# Azure
elif [[ $cloud == 'az' ]]; then

    azure(){
        az login
        az storage file upload --account-name $accountname\
        --account-key $accountkey \
        --share-name $sharename \
        --path $path --source $file
    }

else
    echo 'please run again using aws or az'
fi

# CLI Argument Parsing

# File Check

# File Upload