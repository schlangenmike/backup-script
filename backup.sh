#!/bin/bash

# backup.sh - Create timestamped backups of directories

# Check if directory argument provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <directory-to-backup>"
    echo "Example: $0 ~/Documents/important-files"
    exit 1
fi

SOURCE_DIR="$1"
BACKUP_DIR="$HOME/backups"
TIMESTAMP=$(date '+%Y-%m-%d-%H%M%S')
BACKUP_NAME="backup-$TIMESTAMP.tar.gz"

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "❌ Error: Directory '$SOURCE_DIR' does not exist"
    exit 1
fi

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

echo "🔄 Creating backup..."
echo "Source: $SOURCE_DIR"
echo "Destination: $BACKUP_DIR/$BACKUP_NAME"

# Create the backup
tar -czf "$BACKUP_DIR/$BACKUP_NAME" -C "$(dirname "$SOURCE_DIR")" "$(basename "$SOURCE_DIR")"

if [ $? -eq 0 ]; then
    echo "✅ Backup created successfully!"
    echo "📦 Backup file: $BACKUP_DIR/$BACKUP_NAME"
    
    # Show backup size
    BACKUP_SIZE=$(du -h "$BACKUP_DIR/$BACKUP_NAME" | cut -f1)
    echo "📊 Size: $BACKUP_SIZE"
else
    echo "❌ Backup failed!"
    exit 1
fi
