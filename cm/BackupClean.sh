#!/bin/bash

find ~/backups -name "*.tar.gz" -mtime -25 -delete
echo "Removed Backups older than 25 days"
