#!/usr/bin/zsh

read "VAL?Do you want to update all packages? [Y/n]: "

if [[ -z $VAL || $VAL == [Yy] ]]
then
    sudo pacman -Syu
    pkill -RTMIN+7 waybar # update counter immediately
    read -k1 "?Press any key to exit..."
else
    exit
fi
