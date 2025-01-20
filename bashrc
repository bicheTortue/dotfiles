
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

###########
# aliases #
###########
if [ ! -z "$(command -v eza)" ]
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

ssprint() {
  if [ $# -lt 2 ]
  then
    echo "Usage: $funcstack[1] <host> <file>"
    return
  else
    ssh $1 lpr < $2
  fi
}

#################
# Prompt styles #
#################
# My basic prompt
PS1='\[\033[01;36m\]\u\[\033[01;31m\]@\[\033[01;32m\]\h\[\033[01;34m\]\w\[\033[01;33m\]\$\[\033[01;00m\] '


####################
# Program Specific #
####################
if [ ! -z "$(command -v starship)" ]
then
  eval "$(starship init bash)"
fi

if [ ! -z "$(command -v quartus)" ]
then
  export QSYS_ROOTDIR="/opt/intelFPGA/23.1/quartus/sopc_builder/bin"
fi


#################
# Host Specific #
#################

if [ $(hostname) == "front" ]; then
  send-file(){
  if [ $# -lt 1 ]
  then
    echo "Usage: $funcstack[1] <file>"
    return
  else
    scp $1 ducas:~/Drafts/
  fi
}
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/software/python/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
  eval "$__conda_setup"
else
  if [ -f "/software/python/anaconda3/etc/profile.d/conda.sh" ]; then
    . "/software/python/anaconda3/etc/profile.d/conda.sh"
  else
    export PATH="/software/python/anaconda3/bin:$PATH"
  fi
fi
unset __conda_setup
# <<< conda initialize <<<
fi

