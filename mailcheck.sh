#!/bin/bash
# Check for new mail with OfflineImap

# Define the location of OfflineImap, along with any options.
OFFLINEIMAP='/usr/bin/offlineimap'


# If there are no OfflineImap processes running, start a continuously running
# background process.
if ! ps ax | grep -v grep | grep -q "`echo $OFFLINEIMAP | sed 's/ .*//'`"; then
    $OFFLINEIMAP -u quiet&
# If a process is already running, run OfflineImap once.
else
    $OFFLINEIMAP -o $@
fi
