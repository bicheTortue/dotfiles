# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH


if test -d $HOME/.oh-my-zsh
then
  export ZSH="$HOME/.oh-my-zsh"

  ZSH_THEME="valgnoster"

  plugins=(
    git
    archlinux
    zsh-autosuggestions
    zsh-syntax-highlighting
  )

  source $ZSH/oh-my-zsh.sh
fi

# Check archlinux plugin commands here
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/archlinux

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
  ssh $1 lpr < $2
}

####################
# Program Specific #
####################

# Display Pokemon-colorscripts
# Project page: https://gitlab.com/phoneybadger/pokemon-colorscripts#on-other-distros-and-macos
if [ ! -z "$(command -v pokemon-colorscripts)" ]
then
  pokemon-colorscripts --no-title -s -r
fi


# Set-up FZF key bindings (CTRL R for fuzzy history finder)
if [ ! -z "$(command -v fzf)" ]
then
  source <(fzf --zsh)
fi

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

if [ ! -z "$(command -v quartus)" ]
then
  export QSYS_ROOTDIR="/opt/intelFPGA/23.1/quartus/sopc_builder/bin"
fi
