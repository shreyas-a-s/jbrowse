#!/bin/bash

# JBrowse Install script by @shreyas-a-s

# Install system pre-requisites
sudo apt update && sudo apt install build-essential zlib1g-dev -y

# Functions

function getJBrowseNormal {
    sudo apt install unzip curl -y
    curl -L -O https://github.com/GMOD/jbrowse/releases/download/1.16.11-release/JBrowse-1.16.11.zip
    unzip JBrowse-1.16.11.zip
    mv JBrowse-1.16.11 /var/www/html/jbrowse
    cd /var/www/html/jbrowse/ || exit
    ./setup.sh
}

function getJBrowseWithPluginSupport {
    sudo apt install git -y
    git clone https://github.com/gmod/jbrowse
    cd jbrowse || exit
    git checkout 1.16.11-release
    ./setup.sh
    mv ../jbrowse /var/www/html/
}

# Getting user choice
flag=true
echo -e "################################\n##### JBrowse Installation #####\n################################"
while [ $flag == true ] ; do
    read -r -p "You want plugin-support? (yes/no): " choice
	if [ "$choice" == 'yes' ]; then
		getJBrowseWithPluginSupport
		flag=false
	elif [ "$choice" == 'no' ]; then
		getJBrowseNormal
		flag=false
	else
		echo "You have given invalid option. Choose either yes or no."
		echo ""
	fi
done

# Test out the install
echo "To check if the installation succeeded, go to http://localhost/jbrowse/"
