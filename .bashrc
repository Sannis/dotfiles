#!/bin/bash

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

# Default editor
if [ -f /usr/bin/mcedit ]; then
  export EDITOR=/usr/bin/mcedit
else
  export EDITOR=/usr/bin/nano
fi

# Java JDK dir for PHPStorm
export WEBIDE_JDK=/usr/lib/jvm/java-1.6.0-sun-1.6.0/jre

# History settings
export HISTFILESIZE=1000000000
export HISTSIZE=1000000
export HISTCONTROL=ignoreboth:erasedups   # no duplicate entries
shopt -s histappend                       # append history file
export PROMPT_COMMAND="history -a"        # update histfile after every command
