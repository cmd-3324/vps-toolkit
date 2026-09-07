tar -czf ~/mini-digi-backup-$(date +%F).tar.gz -C ~/mini-digi --exclude="venv" --exclude="__pycache__" .
echo "Backup completed $(date +%F)"
