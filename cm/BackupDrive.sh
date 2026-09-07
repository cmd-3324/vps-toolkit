#!/bin/bash

# Settings
SOURCE_FOLDER="/home/POC/mini-digi" 
BACKUP_NAME="backup"
DESTINATION="gdrive:VPS_Backups/"

# Create timestamp
TIMESTAMP=$(date +'%Y-%m-%d_%H-%M-%S')
ZIP_FILE="${BACKUP_NAME}_${TIMESTAMP}.zip"

zip -r "$ZIP_FILE" "$SOURCE_FOLDER" \
  -x "*/.git/*" \
  -x "*/node_modules/*" \
  -x "*/venv/*" \
  -x "*.log" || { echo "ZIP FAILED"; exit 1; }

# This avoids deleting file if upload failed due to connection or Any fucking reason
if rclone copy "$ZIP_FILE" "$DESTINATION" --retries=3; then
    rm "/home/POC/$ZIP_FILE"
    echo "Backup completed: $ZIP_FILE"
else
    echo "UPLOAD FAILED - LOCAL ZIP PRESERVED AT /home/POC/$ZIP_FILE" >&2
    exit 1
fi
