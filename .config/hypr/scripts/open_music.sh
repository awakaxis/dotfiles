#!/usr/bin/zsh

VAL=$(hyprctl clients -j | jq -r '.[] | "\(.title)"')


hyprctl clients -j | jq -r '.[] | "\(.title)"' | while IFS= read -r title; do
    if [[ "$title" == "rmpc" ]]; then
        hyprctl 'dispatch focuswindow title:^(rmpc)'
        exit 0
    fi
done

hyprctl 'dispatch exec [workspace 10] kitty rmpc'
