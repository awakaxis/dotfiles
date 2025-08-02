#!/usr/bin/zsh
LANG=$(ibus engine)

if [[ $LANG == "anthy" ]]; then
    echo "JP"
else
    echo "EN"
fi
