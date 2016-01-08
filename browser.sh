#!/bin/sh

menu=$(echo -e "firefox -P default\nfirefox -P work\ndisposable chromium" | rofi -dmenu -p "browser " -no-custom)

eval $menu \"$@\" > /dev/null 2>&1 &
