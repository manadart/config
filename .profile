# If not running interactively, don't do anything.
[[ $- != *i* ]] && return

alias ls='ls -lh --color=auto'
alias la='ls -lah --color=auto'
alias wifi='sudo wifi-menu'
alias tm='tmux -2'
alias v='vim'
alias batt='upower -i $(upower -e | grep BAT) | grep --color=never -E "state|to\ full|to\ empty|percentage"'
alias usbm='udisksctl mount -b'
alias usbu='udisksctl unmount -b'

alias venvs="/bin/ls ~/.venvs/"
vact(){ source "/home/joseph/.venvs/$1/bin/activate"; }

# Used as part of running the SSH agent automatically.
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# This prevents blanked windows in IntelliJ IDEA.
export _JAVA_AWT_WM_NONREPARENTING=1

# Prevents error in SBT.
export TERM=xterm-color
