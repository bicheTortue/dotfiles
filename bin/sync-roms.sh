#!/bin/bash

# Define where to save our logs so we can troubleshoot if needed
LOGFILE="/dev/null"
#LOGFILE="$HOME/sync_log.txt"
echo "--- Syncing Roms ---" > "$LOGFILE"
rclone copy barbanuage:Emulation/Roms ~/Emulation/Roms -v >> "$LOGFILE" 2>&1

