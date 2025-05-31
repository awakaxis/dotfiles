#!/usr/bin/zsh

read "VAL?Do you want to update all packages? [Y/n]: "

if [[ -z $VAL || $VAL == [Yy] ]]
then
    sudo pacman -Syu
else
    exit
fi
