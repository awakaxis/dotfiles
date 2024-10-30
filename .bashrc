PS1='\[\e[32m\]\u\[\e[2m\]@\[\e[22m\]\@\[\e[35m\] \[\e[33m\]\w\n\[\e[0;2m\]\\$\[\e[0m\]'

export PYTHON_FORCE_COLOR=1
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

ROBLOX_DIR="C:\Users\awakaxis\AppData\Local\Roblox\Versions"

alias cls="clear"
alias myip="curl -s -w \"\n\" ipinfo.io/ip | tee /dev/clipboard"
alias rsource="source ~/.bashrc"
alias nanorc="nano ~/.bashrc"
alias nanoz="nano ~/.wezterm.lua"
alias awakaxis@pi="ssh awakaxis@192.168.1.15"

#utility
alias findsizmod="find . -type f -exec stat -c \"%s %y %n\" {} + | awk '{$1=$1; print $0}' | numfmt --to=iec --field 1 --padding -5 | awk '{$3=$3; sub(/\.[0-9]+/, \"\", $3); print $0}'"

#working directories
alias home="cd ~"
alias kcord_bot="cd ~/Documents/dev/'Discord Dev'/'Shitty kcord ai'"
alias qtest="cd ~/Documents/dev/minecraft/'minecraft java modding'/quiltmc-testing"

alias roblox='find $(echo $ROBLOX_DIR | sed "s/\\\/\//g") -name "RobloxPlayerBeta.exe" -exec {} \; &'
