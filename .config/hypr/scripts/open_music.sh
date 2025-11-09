#!/usr/bin/zsh

VAL=$(hyprctl clients -j | jq -r '.[] | "\(.title)"')


hyprctl clients -j | jq -r '.[] | "\(.title)"' | while IFS= read -r title; do
    if [[ "$title" == "rmpc" ]]; then
        hyprctl dispatch workspace 5
        exit 0
    fi
done

hyprctl 'dispatch exec [workspace 5] kitty rmpc'
