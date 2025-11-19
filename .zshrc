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
alias rsource='cls && source ~/.zshrc'
alias venvpy='.venv/bin/python'
alias hyprpicker='hyprpicker | grep -P "#\w{6}" | wlc'
alias hyprkill='hyprctl kill'
alias ff='cls && fastfetch'
alias fortsai='cbonsai -li -t 0.05 -L 32 -M 10 -w 10 -m "$(fortune)"'
alias myip="curl -s -w \"\n\" ipinfo.io/ip | wlc"

ytdlp ()
{
    if [[ -z $1 || ( $1 != "music" && $1 != "video" ) ]]; then
        echo "Usage: ytdlp [music, video] [args...]"
        echo "Shortcut for music or video presets for yt-dlp."
        return
    fi
    if [[ $1 == "music" ]]; then
        yt-dlp $2 -x --embed-thumbnail --write-thumbnail --embed-metadata --write-subs --sub-langs 'en,ja' --convert-subs lrc -o '/home/awakaxis/Music/ytdlp/%(channel)s/%(title)s/%(title)s.%(ext)s' -o 'thumbnail:/home/awakaxis/Pictures/music_thumbnails/%(title)s.%(ext)s'
    fi
}

alias litecli='litecli --auto-vertical-output'

# vim shortcuts
alias vim='nvim'
alias vimrc='vim ~/.zshrc'
alias vimhypr='cd ~/.config/hypr/ && vim hyprland.conf'
alias vimte='vim ~/.config/kitty/kitty.conf'

mkcd() {
    mkdir $1
    cd $1
};

# fzf
eval "$(fzf --zsh)"

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND --no-ignore"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

_fzf_compgen_path() {
    fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
    fd --type=d --hidden --exclude .git . "$1"
}

# bat
export BAT_THEME="gruvbox-dark"
alias cat=bat

# zoxide
eval "$(zoxide init zsh)"
alias cd="z"

# Created by `pipx` on 2025-05-12 19:07:26
export PATH="$PATH:/home/awakaxis/.local/bin"

export PINGME_ADDRESS=192.168.1.16
export PINGME_PORT=25657
export PINGME_FORMAT="\`%usr@%hst %cwd\` finished \`%cmd\` in \`%dur\`"
export PINGME_USER_ID=424752785142317066

preexec() {
    export PINGME_TIMESTAMP=$(date +%s)
    export PINGME_CMD=${1% |*}
}

fastfetch
