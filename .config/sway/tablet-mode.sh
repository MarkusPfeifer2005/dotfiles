#!/bin/bash
swaymsg -m -t subscribe '["input"]' | jq --unbuffered -c '.' | while read -r line; do
    #echo $line
    #echo "$line" | jq "{change: .change, identifier: .input.identifier}"
    if echo "$line" | grep -q '"change":"removed"' && echo "$line" | grep -q 'Microsoft_Surface_Type_Cover_Keyboard'; then
        squeekboard &
    elif echo "$line" | grep -q '"change":"added"' && echo "$line" | grep -q 'Microsoft_Surface_Type_Cover_Keyboard'; then
        killall squeekboard
    fi
done
