#!/bin/bash

# This script disable all porn-sites, gambling-sites and unified-hosts
# Based and Steven Black repot: https://github.com/StevenBlack/hosts
# You will change what you want to block modifying the link of the variable URL_HOSTS

hosts_mod() {

    HOSTS_FILE="/etc/hosts"
    BACKUP_FILE="/etc/hosts.backup"
    URL_HOSTS="https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/gambling-porn/hosts"

    echo "<<<.....Creating backup of hosts file.....>>>"

    # Check if the hosts file exists before creating a backup
    if [ -f "$HOSTS_FILE" ]; then
        # Copy the current hosts file to the backup file
        cp "$HOSTS_FILE" "$BACKUP_FILE"

        # Check if the backup was successful
        if [ $? -eq 0 ]; then
            echo "<<<.....Backup created successfully: $BACKUP_FILE.....>>>"
        else
            echo "<<<.....Failed to create backup. Exiting.....>>>"
            exit 1
        fi
    else
        echo "<<<.....Error: Hosts file $HOSTS_FILE not found. Cannot create backup. Exiting.....>>>"
        exit 1
    fi

    echo "<<<.....Updating hosts file from $URL_HOSTS.....>>>"

    # Download and update hosts file from the specified URL
    curl -s "$URL_HOSTS" -o "$HOSTS_FILE"

    if [ $? -eq 0 ]; then
        sudo systemd-resolve --flush-caches
        sudo systemctl restart NetworkManager.service
        echo "<<<.....Hosts file updated successfully.....>>>"
       
    else
        echo "<<<.....Failed to update hosts file. Restoring backup.....>>>"
        # Restore the backup hosts file if update fails
        cp "$BACKUP_FILE" "$HOSTS_FILE"
        exit 1
    fi

}
