#!/bin/bash

user=$(whoami)
timestamp=$(date +%Y-%m-%d-%H-%M-%S)
base="/home/$user/backups/Backup-$timestamp"

mkdir -p "$base"

sudo tar -czf "$base/home-$timestamp.tar.gz" --exclude="/home/$user/backups" /home 2>/dev/null
echo "Created: $base/home-$timestamp.tar.gz"

sudo tar -czf "$base/etc-$timestamp.tar.gz" /etc 2>/dev/null
echo "Created: $base/etc-$timestamp.tar.gz"

sudo tar -czf "$base/www-$timestamp.tar.gz" /var/www 2>/dev/null
echo "Created: $base/www-$timestamp.tar.gz"

sudo tar -czf "$base/var-$timestamp.tar.gz" --exclude="/var/lib/mysql" /var 2>/dev/null
echo "Created: $base/var-$timestamp.tar.gz"

echo "Backup complete: $base"
