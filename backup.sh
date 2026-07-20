#!/bin/bash

# Backup Script
#
# Author: Emmanuel
# Description:
# Creates a compressed backup (.tar.gz) of a directory
# and automatically deletes backups older than 14 days.

# ==========================================
# Check if the script is running as root
# ==========================================

if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with sudo."
    exit 1
fi

# =====
# Help
# =====

if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    echo -e "Usage:\n  ./backup.sh <directory>\n\nExample:\n  ./backup.sh /home/emmanuel/Documents"
    exit 0
fi

# =====================================================
# Initialize the backup directory and archive filename
# =====================================================

BACKUP_DIR="/backup"

if [ ! -d "$BACKUP_DIR" ]; then
    echo "[INFO] Backup directory '$BACKUP_DIR' does not exist. Creating it..."
    mkdir -p "$BACKUP_DIR"

    if [ "$?" -ne 0 ]; then
        echo "[ERROR] Failed to create the backup directory."
        exit 1
    else
        echo "[SUCCESS] Backup directory created successfully."
    fi
else
    echo "[INFO] Backup directory already exists."
fi

# Archive name

DATE=$(date +%Y-%m-%d_%H-%M-%S)
ARCHIVE_NAME="backup_$DATE.tar.gz"
ARCHIVE_PATH="$BACKUP_DIR/$ARCHIVE_NAME"

# ==========================================
# Validate the source directory
# ==========================================

SOURCE_DIR="$1"

while [ -z "$SOURCE_DIR" ] || [ ! -d "$SOURCE_DIR" ]; do
    read -p "Enter the absolute path of the directory to back up: " SOURCE_DIR

    if [ -d "$SOURCE_DIR" ]; then
        echo "[SUCCESS] Directory found."
        break
    else
        echo "[ERROR] The specified directory does not exist."
    fi
done

# ==========================
# Start the backup process
# ==========================

tar -czf "$ARCHIVE_PATH" -C "$(dirname "$SOURCE_DIR")" "$(basename "$SOURCE_DIR")"

if [ $? -ne 0 ]; then
    echo "[ERROR] Failed to create the backup of '$(basename "$SOURCE_DIR")'."
else
    echo "[SUCCESS] Backup completed successfully."
    echo "[INFO] Archive created: $ARCHIVE_NAME"
fi

# ==========================================
# Delete backups older than 14 days
# ==========================================

find "$BACKUP_DIR" -name "backup_*.tar.gz" -mtime +14 -delete