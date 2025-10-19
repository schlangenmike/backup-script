# Backup Script

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

## Requirements

- Bash
- tar (pre-installed on macOS/Linux)
