# Backup Script

![Version](https://img.shields.io/badge/version-1.1.0-blue)

A simple bash script to create timestamped, compressed backups of directories with comprehensive logging.

## Usage
```bash
./backup.sh <directory-to-backup>
```

## Example
```bash
./backup.sh ~/Documents/important-files
```

## Features

- Creates compressed `.tar.gz` backups
- Adds timestamp to each backup
- Stores backups in `~/backups/`
- Shows backup size after completion
- Automatically keeps only the 5 most recent backups
- **Comprehensive logging of all operations** (logs stored in `~/backups/backup.log`)

## Version

Current version: **1.1.0**

### Changelog
- v1.1.0 (2025-10-29)
  - Added comprehensive logging system
  - Logs all backup operations with timestamps
  - Tracks success/failure, sizes, and cleanup actions
  - Audit trail for all backup activities

- v1.0.0 (2025-10-19)
  - Initial release
  - Timestamped compressed backups
  - Automatic cleanup (keep last 5)
  - Cross-platform support

## Logging

All backup operations are logged to `~/backups/backup.log` with:
- Timestamps for each operation
- Success/failure status
- Backup sizes and locations
- Cleanup actions
- Error messages

View logs:
```bash
cat ~/backups/backup.log
```

## Requirements

- Bash
- tar (pre-installed on macOS/Linux)