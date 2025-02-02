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

source $HOME/.comshrc
