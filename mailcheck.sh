#!/bin/bash
# Check for new mail with OfflineImap

# Define the location of OfflineImap, along with any options.
OFFLINEIMAP='/usr/bin/offlineimap -u quiet'


# If there are no OfflineImap processes running, start a continuously running
# background process.
if ! ps ax | grep -v grep | grep -q "`echo $OFFLINEIMAP | sed 's/ .*//'`"; then
    $OFFLINEIMAP&
# If a process is already running, run OfflineImap once.
else
    $OFFLINEIMAP -o
fi
