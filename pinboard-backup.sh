#!/bin/bash

source ~/.keys/creds.sh

tmp=$(mktemp)
destination="$HOME/documents/pinboard.json"

if curl -Ss "https://api.pinboard.in/v1/posts/all?auth_token=$PINBOARD_USER:$PINBOARD_KEY&format=json" -o "$tmp"; then
    if python -m json.tool "$tmp" >> /dev/null; then
        mv "$tmp" "$destination"
    else
        echo "Output does not appear to be valid JSON: $tmp"
        exit 3
    fi
else
    echo "Something went wrong."
    exit 2
fi
