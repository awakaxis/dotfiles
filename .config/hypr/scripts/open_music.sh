#!/usr/bin/zsh

if [[ "$(hyprctl clients -j | jq -r '.[] | "\(.title)"')" == *"rmpc"* ]]; then
    hyprctl dispatch workspace 5
else
    hyprctl "dispatch exec [workspace 5] kitty rmpc"
fi
