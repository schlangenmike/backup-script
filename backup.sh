#!/bin/bash

VERSION="1.0.0"

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
echo "Version: $VERSION"
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

    # Clean up old backups (keep only last 5)
    echo ""
    echo "🧹 Cleaning up old backups..."

    BACKUP_COUNT=$(ls -1 "$BACKUP_DIR"/backup-*.tar.gz 2>/dev/null | wc -l)

    if [ "$BACKUP_COUNT" -gt 5 ]; then
        echo "Found $BACKUP_COUNT backups, keeping only the 5 most recent..."
        ls -1t "$BACKUP_DIR"/backup-*.tar.gz | tail -n +6 | xargs rm -f
        echo "✅ Cleanup complete!"
    else
        echo "Only $BACKUP_COUNT backup(s) exist, no cleanup needed."
    fi

else
    echo "❌ Backup failed!"
    exit 1
fi
