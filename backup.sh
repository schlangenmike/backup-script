#!/bin/bash

VERSION="1.1.0"

# backup.sh - Create timestamped backups of directories

# Configuration
BACKUP_DIR="$HOME/backups"
LOG_FILE="$BACKUP_DIR/backup.log"

# Logging function
log_message() {
    local level=$1
    shift
    local message="$@"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$level] $message" | tee -a "$LOG_FILE"
}

# Check if directory argument provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <directory-to-backup>"
    echo "Example: $0 ~/Documents/important-files"
    log_message "ERROR" "No directory specified"
    exit 1
fi

SOURCE_DIR="$1"
TIMESTAMP=$(date '+%Y-%m-%d-%H%M%S')  
BACKUP_NAME="backup-$TIMESTAMP.tar.gz"

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "❌ Error: Directory '$SOURCE_DIR' does not exist"
    log_message "ERROR" "Source directory does not exist: $SOURCE_DIR"
    exit 1
fi

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

echo "🔄 Creating backup..."
echo "Version: $VERSION"  
echo "Source: $SOURCE_DIR"
echo "Destination: $BACKUP_DIR/$BACKUP_NAME"

log_message "INFO" "Starting backup of $SOURCE_DIR"

# Create the backup
tar -czf "$BACKUP_DIR/$BACKUP_NAME" -C "$(dirname "$SOURCE_DIR")" "$(basename "$SOURCE_DIR")"

if [ $? -eq 0 ]; then
    # Show backup size
    BACKUP_SIZE=$(du -h "$BACKUP_DIR/$BACKUP_NAME" | cut -f1)
    
    echo "✅ Backup created successfully!"
    echo "📦 Backup file: $BACKUP_DIR/$BACKUP_NAME"
    echo "📊 Size: $BACKUP_SIZE"
    
    log_message "SUCCESS" "Backup created: $BACKUP_NAME (Size: $BACKUP_SIZE, Source: $SOURCE_DIR)"
    
    # Clean up old backups (keep only last 5)
    echo ""
    echo "🧹 Cleaning up old backups..."
    
    BACKUP_COUNT=$(ls -1 "$BACKUP_DIR"/backup-*.tar.gz 2>/dev/null | wc -l)
    
    if [ "$BACKUP_COUNT" -gt 5 ]; then
        echo "Found $BACKUP_COUNT backups, keeping only the 5 most recent..."
        OLD_BACKUPS=$(ls -1t "$BACKUP_DIR"/backup-*.tar.gz | tail -n +6)
        DELETED_COUNT=$(echo "$OLD_BACKUPS" | wc -l)
        
        echo "$OLD_BACKUPS" | xargs rm -f
        
        echo "✅ Cleanup complete!"
        log_message "INFO" "Cleanup: Removed $DELETED_COUNT old backup(s)"
    else
        echo "Only $BACKUP_COUNT backup(s) exist, no cleanup needed."
        log_message "INFO" "Cleanup: No old backups to remove ($BACKUP_COUNT total)"
    fi
    
    log_message "INFO" "Backup operation completed successfully. Total backups: $(ls -1 "$BACKUP_DIR"/backup-*.tar.gz 2>/dev/null | wc -l)"
else
    echo "❌ Backup failed!"
    log_message "ERROR" "Backup failed for $SOURCE_DIR"
    exit 1
fi
