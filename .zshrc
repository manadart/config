# Created by newuser for 5.4.2

[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

autoload -Uz promptinit
promptinit

git_branch () {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

setopt prompt_subst
PROMPT='%F{blue}%*%f %F{green}%3~%f %F{cyan}$(git_branch)%f%B%F{yellow}->%f%b '

# Completion
autoload -U compinit
compinit

# Correction
setopt correctall

# Ignore duplicates in history (for up arrow).
setopt histignoredups

# Syntax Highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

HISTFILE=~/.histfile
HISTSIZE=50000
SAVEHIST=50000

# Maintain the directory history.

DIRSTACKFILE="$HOME/.cache/zsh/dirs"
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  [[ -d $dirstack[1] ]] && cd $dirstack[1]
fi
chpwd() {
  print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}

DIRSTACKSIZE=20

setopt AUTO_PUSHD PUSHD_SILENT PUSHD_TO_HOME

# Remove duplicate entries.
setopt PUSHD_IGNORE_DUPS

# This reverts the +/- operators.
setopt PUSHD_MINUS
