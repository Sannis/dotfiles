# .bashrc

# Source global definitions
#==========================
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases
#======================
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# User specific prompt
#=====================
if [ -f ~/.bash_prompt ]; then
	. ~/.bash_prompt
fi

# Common settings
#================

# History settings
set -o history
HISTFILESIZE=1000000000
HISTSIZE=1000000
HISTCONTROL=ignoredups
#shopt -s histappend

# Default editor
if [ -f /usr/bin/mcedit ]; then
	export EDITOR=/usr/bin/mcedit
else
	export EDITOR=/usr/bin/nano
fi

# Java JDK dir for PHPStorm
export WEBIDE_JDK=/usr/lib/jvm/java-1.6.0-sun-1.6.0/jre

# OS specific settings
if [[ $OSTYPE == darwin* ]]; then
	if [ -f ./darwin/bashrc ]; then
		. ./darwin/bashrc
	fi
fi
