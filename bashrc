
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

###########
# aliases #
###########
if [ ! -z "$(which eza 2> /dev/null)" ]
then
  alias ls='eza'
  alias ll='eza -l'
  alias ll2='eza -l --tree --level=2'
  alias lla='eza -la'
else
  alias ls='ls --color=auto'
  alias ll='ls -hlF'
  alias lla='ls -hlFa'
fi

#################
# Prompt styles #
#################
# My basic prompt
PS1='\[\033[01;36m\]\u\[\033[01;31m\]@\[\033[01;32m\]\h\[\033[01;34m\]\w\[\033[01;33m\]\$\[\033[01;00m\] '


####################
# Program Specific #
####################
if [ ! -z "$(which starship 2> /dev/null)" ]
then
  eval "$(starship init bash)"
fi

if [ ! -z "$(command -v quartus)" ]
then
  export QSYS_ROOTDIR="/opt/intelFPGA/23.1/quartus/sopc_builder/bin"
fi
