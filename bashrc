# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

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

#################
# Host Specific #
#################

if [ "$(cat /proc/sys/kernel/hostname)" = "front" ]; then
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

source $HOME/.comshrc # For common stuff
