# Backup Script

![Version](https://img.shields.io/badge/version-1.0.0-blue)

A simple bash script to create timestamped, compressed backups of directories.

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

## Version

Current version: **1.0.0**

### Changelog
- v1.0.0 (2025-10-19)
  - Initial release
  - Timestamped compressed backups
  - Automatic cleanup (keep last 5)
  - Cross-platform support

## Requirements

- Bash
- tar (pre-installed on macOS/Linux)
