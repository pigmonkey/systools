#!/bin/sh
khal list -d "Work: Staff" --format "{calendar-color}{start-time-full} - {end-time-full} {title}"
task list
read -p "Press Enter to quit."
