#!/bin/bash

# Define where to save our logs so we can troubleshoot if needed
LOGFILE="/dev/null"
#LOGFILE="$HOME/sync_log.txt"
echo "--- Starting Sync & Play at $(date) ---" > "$LOGFILE"

# 1. Define the Upload Function (The Dead-Man's Switch)
push_saves() {
  echo "Game closed! Pushing saves to Nextcloud..." >> "$LOGFILE"
  rclone copy ~/Emulation/saves barbanuage:Emulation/Saves -v >> "$LOGFILE" 2>&1
  echo "Push complete." >> "$LOGFILE"
}

# 2. Set the Trap
# This forces the 'push_saves' function to run on EXIT, or if Steam sends a SIGTERM/SIGINT kill signal
trap push_saves EXIT SIGTERM SIGINT

# 3. Pull latest saves before launch
echo "Pulling latest saves from Nextcloud..." >> "$LOGFILE"
rclone copy barbanuage:Emulation/Saves ~/Emulation/saves -v >> "$LOGFILE" 2>&1

# 4. Run the Game
echo "Launching game command: $@" >> "$LOGFILE"
"$@"
