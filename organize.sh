#!/usr/bin/env sh


DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

###############################
# Files in the home directory #
###############################

# bashrc
if [ ! -z "$(command -v bash)" ]
then
  echo -e "${GREEN}bash is installed, linking config${NC}"
  ln -fs $DIR/bashrc $HOME/.bashrc
else
  echo -e "${RED}bash is not installed on this machine${NC}"
fi

# zshrc
if [ ! -z "$(command -v zsh)" ]
then
  echo -e "${GREEN}zsh is installed, linking config${NC}"
  ln -fs $DIR/zshrc $HOME/.zshrc
else
  echo -e "${RED}zsh is not installed on this machine${NC}"
fi

##################################
# Files in the .config directory #
##################################
mkdir -p $HOME/.config

# kitty
if [ ! -z "$(command -v kitty)" ]
then
  echo -e "${GREEN}Kitty is installed, linking config${NC}"
  rm -rf $HOME/.config/kitty
  ln -sf $DIR/kitty $HOME/.config/kitty
else
  echo -e "${RED}Kitty is not installed on this machine${NC}"
fi

# hyprland
if [ ! -z "$(command -v Hyprland)" ]
then
  echo -e "${GREEN}Hyprland is installed, linking config${NC}"
  rm -rf $HOME/.config/hypr
  ln -sf $DIR/hypr $HOME/.config/hypr
else
  echo -e "${RED}Hyprland is not installed on this machine${NC}"
fi

# waybar
if [ ! -z "$(command -v waybar)" ]
then
  echo -e "${GREEN}Waybar is installed, linking config${NC}"
  rm -rf $HOME/.config/waybar
  ln -sf $DIR/waybar $HOME/.config/waybar
else
  echo -e "${RED}Waybar is not installed on this machine${NC}"
fi

# starship prompt
if [ ! -z "$(command -v starship)" ]
then
  echo -e "${GREEN}Starship is installed, linking config${NC}"
  ln -fs $DIR/starship.toml $HOME/.config/starship.toml
else
  echo -e "${RED}Starship is not installed on this machine${NC}"
fi

##############
# vim config #
##############

if [ ! -z "$(command -v vim)" ]
then
  echo -e "${GREEN}Vim is installed, linking config${NC}"
  ln -fs $DIR/vimrc $HOME/.vimrc
  mkdir -p $HOME/vim/bundle
  if [ ! -z "$(command -v git)" ]
  then
    echo "  Downloading plugin manager..."
    git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim &> /dev/null
    echo "  Installing plugins..."
    echo | vim +PluginInstall +qall &> /dev/null
  else
    echo "git is needed to install the plugin manager"
  fi
else
  echo -e "${RED}Vim is not installed on this machine${NC}"
fi

####################
# ssh config files #
####################
if [ ! -z "$(command -v ssh)" ]
then
  echo -e "${GREEN}ssh is installed, linking config${NC}"
  mkdir -p $HOME/.ssh
  ln -fs $DIR/ssh/config $HOME/.ssh/config
  for f in ssh/*.pub
  do
    KEY_TAG=$(awk '{print $2}' $f)
    if [ -z "$(grep $KEY_TAG $HOME/.ssh/authorized_keys)" ]
    then
      echo -e "  Adding $f to authorized keys"
      cat $f >> $HOME/.ssh/authorized_keys
    fi
  done
else
  echo -e "${RED}ssh is not installed on this machine${NC}"
fi

###############
# backgrounds #
###############

mkdir -p $HOME/Pictures/backgrounds
ln -sf $DIR/bg $HOME/Pictures/backgrounds
