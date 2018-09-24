#!/bin/bash

source ~/.keys/creds.sh

tmp=$(mktemp)
destination="$HOME/library/conf/"

if curl -Ss "https://api.pinboard.in/v1/posts/all?auth_token=$PINBOARD_USER:$PINBOARD_KEY&format=json" -o "$tmp"; then
    if python -m json.tool "$tmp" >> /dev/null; then
        cd "$destination"
        git annex edit pinboard.json
        mv "$tmp" "$destination/pinboard.json"
        git annex sync -m "pinboard update"
        $HOME/bin/bookmark-archiver
    else
        echo "Output does not appear to be valid JSON: $tmp"
        exit 3
    fi
else
    echo "Something went wrong."
    exit 2
fi
