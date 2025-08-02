# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f ~/.secrets/env_vars ]; then
	source ~/.secrets/env_vars
fi

PS1='%F{#EFEBD9}%n%f@%F{#EFEBD9}%M -> %U%2~%u %f'$'\n'' $ '
export EDITOR='nvim'
export GLFW_IM_MODULE=ibus

alias poweroff='systemctl poweroff'

alias ls='ls --color=auto'
alias lsa='ls -a'
alias grep='grep --color=auto'

alias wlc='wl-copy'
alias cls='clear'
alias rsource='source ~/.zshrc'
alias venvpy='.venv/bin/python'
alias hyprpicker='hyprpicker | grep -P "#\w{6}" | wlc'

alias litecli='litecli --auto-vertical-output'

# vim shortcuts
alias vim='nvim'
alias vimrc='vim ~/.zshrc'
alias vimhypr='vim ~/.config/hypr/hyprland.conf'
alias vimte='vim ~/.config/kitty/kitty.conf'

# fzf
eval "$(fzf --zsh)"

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

_fzf_compgen_path() {
    fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
    fd --type=d --hidden --exclude .git . "$1"
}

# bat
export BAT_THEME="gruvbox-dark"

# zoxide
eval "$(zoxide init zsh)"
alias cd="z"

fastfetch

# Created by `pipx` on 2025-05-12 19:07:26
export PATH="$PATH:/home/awakaxis/.local/bin"
