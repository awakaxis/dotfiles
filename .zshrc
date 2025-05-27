# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f ~/.secrets/env_vars ]; then
	source ~/.secrets/env_vars
fi

PS1='%F{#EFEBD9}%n%f@%F{#EFEBD9}%M -> %U%2~%u %f'$'\n'' $ '
export EDITOR='nvim'

alias poweroff='systemctl poweroff'

alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias wlc='wl-copy'
alias cls='clear'
alias rsource='source ~/.zshrc'
alias venvpy='venv/bin/python'
alias hyprpicker='hyprpicker | grep -P "#\w{6}" | wlc'

# vim shortcuts
alias vim='nvim'
alias vimconf='cd ~/.config/nvim; vim .'
alias vimrc='vim ~/.zshrc'
alias vimhypr='vim ~/.config/hypr/hyprland.conf'
alias vimte='vim ~/.config/kitty/kitty.conf'

fastfetch

# Created by `pipx` on 2025-05-12 19:07:26
export PATH="$PATH:/home/awakaxis/.local/bin"
