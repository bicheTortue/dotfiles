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

alias sdate='date +%d/%m/%y'

ssprint() {
  if [ $# -lt 2 ]
  then
    echo "Usage: $funcstack[1] <host> <file> [opts]"
    echo "Use --staples to staple the pages"
    echo "Use -# to choose the number of copies"
  else
    host=$1
    file=$2
    shift; shift
      while [[ $# -gt 0 ]]; do
        case $1 in
          --staples)
            staple="-o Staple=StapleON -o StapleLocation=SinglePortrait"
            shift
            ;;
          *)
            pos_args+=("$1") # save positional arg
            shift # past argument
            ;;
        esac
      done
    ssh $host lpr $pos_args $staple < $file
  fi
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
