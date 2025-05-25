#!/usr/bin/env bash

# Define source and backup directories
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.dotfiles/programs/backups"

# List of folders to backup
FOLDERS=("hypr" "kitty" "rofi" "waybar")

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Copy each folder to the backup directory
for folder in "${FOLDERS[@]}"; do
  SRC="$CONFIG_DIR/$folder"
  DEST="$BACKUP_DIR/$folder"

  if [ -d "$SRC" ]; then
    echo "Backing up $SRC to $DEST"
    # Use rsync to copy preserving attributes and overwriting existing backup
    rsync -a --delete "$SRC/" "$DEST/"
  else
    echo "Warning: $SRC does not exist, skipping."
  fi
done

echo "Backup complete!"

