#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

###########
# aliases #
###########
alias ls='ls --color=auto'
alias ll='ls -hlF'
alias lla='ls -hlFa'

#################
# Prompt styles #
#################
# My basic prompt
PS1='\[\033[01;36m\]\u\[\033[01;31m\]@\[\033[01;32m\]\h\[\033[01;34m\]\w\[\033[01;33m\]\$\[\033[01;00m\] '


####################
# Program Specific #
####################
if [ ! -z "$(which starship > /dev/null 2> /dev/null)" ]
then
  eval "$(starship init bash)"
fi
