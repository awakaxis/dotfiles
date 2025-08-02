#!/usr/bin/zsh
LANG=$(ibus engine)

if [[ $LANG == "anthy" ]]; then
    ibus engine xkb:us::eng
else
    ibus engine anthy
fi


pkill -RTMIN+8 waybar
