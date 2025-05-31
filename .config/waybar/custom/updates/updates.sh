#!/usr/bin/zsh
COUNT=$(checkupdates | wc -l)

if [[ $COUNT == 0 ]]; then
    echo ""
else
    echo $COUNT
fi
