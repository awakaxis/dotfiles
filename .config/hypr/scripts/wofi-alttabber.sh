#!/bin/bash

hyprctl clients -j | jq -r '.[] | "\(.title) [\(.class)] (\(.address))"' |\
    wofi -d -bi --prompt 'Open Windows:' | grep -oP '\(\K[^)]+' |\
    sed 's/^/address:/' | xargs hyprctl dispatch focuswindow
