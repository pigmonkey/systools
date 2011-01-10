#! /usr/bin/env python 
#
# A Python script to calculate total memory usage.
#
# The standard UNIX PS(1) can report memory usage.
# This script merely totals the memory used by each process reported by PS(1)
# and presents the result in a human-readable format.
#
# Author:   Pig Monkey (pm@pig-monkey.com)
# Website:  https://github.com/pigmonkey/systools
#
##############################################################################
import subprocess
import os
import re

# run: ps -u $USER -o rss,comm
p = subprocess.Popen(['ps', '-u', os.getenv('LOGNAME'), '-o', 'rss,comm'],
    stdout=subprocess.PIPE)

# Save the output.
processes = p.communicate()[0]

# Split the output into a list.
process_list = processes.split('\n')

# Add up the memory used by each process.
total = 0
for process in process_list[1:-1]:
    # Strip leading and tailing white space.
    process = process.strip()

    # Get the memory usage for the process.
    mem = re.match('(\d+)\s', process).group(1)

    # Add it to the total.
    total += int(mem)

# Convert kilobytes to megabytes.
if total > 1024:
    total = '%.2f MB' % (float(total) / 1024)
else:
    total = '%d KB' % total

print processes
print 'Total: %s' % total
