# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# User specific aliases
if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
fi

# User specific prompt
if [ -f ~/.bash_prompt ]; then
        . ~/.bash_prompt
fi

# History settings
set -o history
HISTFILESIZE=1000000000
HISTSIZE=1000000
HISTCONTROL=ignoredups
#shopt -s histappend

