#    ██████╗  █████╗ ███████╗██╗  ██╗██████╗  ██████╗
#    ██╔══██╗██╔══██╗██╔════╝██║  ██║██╔══██╗██╔════╝
#    ██████╔╝███████║███████╗███████║██████╔╝██║
#    ██╔══██╗██╔══██║╚════██║██╔══██║██╔══██╗██║
#    ██████╔╝██║  ██║███████║██║  ██║██║  ██║╚██████╗
#    ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝

#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# ---------------------------- ALIAS -----------------------------

# Command styling
alias grep='grep --color=auto'
alias ls='ls -lAh --color=auto --group-directories-first'
alias neofetch='neofetch --disable theme icons --block_width 4 --ascii_bold on --ascii_colors 4 4 --colors 4 7 7 4'
alias rm='rm -i'
alias vtop='vtop -t wizard'
alias df='df -h'

# Go back 1, 2, or 3 levels
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Go to previous directory location
# NOTE: Can just use 'cd -' instead
alias back='cd $OLDPWD'

# Dotfile configuration
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Stopwatch
alias stopwatch='stf=$(date +%s.%N);for ((;;));do ctf=$( date +%s.%N );echo -en "\r$(date -u -d "0 $ctf sec - $stf sec" "+%H:%M:%S.%N")";done'

# ---------------------------- MISC ----------------------------

# Perform 'ls' after 'cd' if successful.
cd() {
    builtin cd "$@" && ls
}

# Use dircolors to configure colored output
if command -v dircolors >/dev/null 2>&1; then
    [ -e "/etc/DIR_COLORS" ] && DIR_COLORS="/etc/DIR_COLORS"
    [ -e "$HOME/.dircolors" ] && DIR_COLORS="$HOME/.dircolors"
    [ -e "$DIR_COLORS" ] || DIR_COLORS=""
    eval "$(dircolors -b "$DIR_COLORS")"
fi

# ---------------------------- VARIABLES ----------------------------

# PROMPT STYLING
BLUE='\[\e[34m\]'
GREEN='\[\e[32m\]'
YELLOW='\[\e[33m\]'
RESET='\[\e[0m\]'

create_prompt() {
    local b
    b=$(git branch --show-current 2>/dev/null)

    if [ -n "$b" ]; then
        PS1="${BLUE}[${RESET}${GREEN}\u${RESET}@\h${BLUE}]${RESET}:\w ${YELLOW}(${b})${RESET}${BLUE}>${RESET}${GREEN}\$${RESET} "

    else
        PS1="${BLUE}[${RESET}${GREEN}\u${RESET}@\h${BLUE}]${RESET}:\w${BLUE}>${RESET}${GREEN}\$${RESET} "
    fi
}

PROMPT_COMMAND=create_prompt

# Use nvim, or vim, or vi
if command -v nvim >/dev/null 2>&1; then
    export VISUAL=nvim
    export EDITOR=nvim
elif command -v vim >/dev/null 2>&1; then
    export VISUAL=vim
    export EDITOR=vim
else
    export VISUAL=vi
    export EDITOR=vi
fi

# Set Rust environment variables
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
