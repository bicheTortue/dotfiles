#!/usr/bin/env sh

DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd ) # The dotfiles repo directory

source $DIR/colors
source $HOME/.config/user-dirs.dirs # Languages specific forlders

###############################
# Files in the home directory #
###############################

# bashrc
if [ ! -z "$(command -v bash)" ]
then
  echo -e "${Green}bash is installed, linking config${NC}"
  ln -fs $DIR/bashrc $HOME/.bashrc
else
  echo -e "${Red}bash is not installed on this machine${NC}"
fi

# zshrc
if [ ! -z "$(command -v zsh)" ]
then
  echo -e "${Green}zsh is installed, linking config${NC}"
  ln -fs $DIR/zshrc $HOME/.zshrc

  # Asking to install omz if not installed
  if ! test -d $HOME/.oh-my-zsh
  then
    echo "Do you want to install oh my zsh ?"
    select yn in "Yes" "No"; do
      case $yn in
        Yes ) sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";;
        No ) ;;
      esac
    done
  fi
  if test -d $HOME/.oh-my-zsh
  then
    if ! test -d $DIR/omz/plugins
    then
      echo "  Installing plugins..."
      mkdir -p $DIR/omz/plugins
      git clone https://github.com/zsh-users/zsh-autosuggestions $DIR/omz/plugins/zsh-autosuggestions &> /dev/null
      git clone https://github.com/zsh-users/zsh-syntax-highlighting $DIR/omz/plugins/zsh-syntax-highlighting &> /dev/null
    fi
    rm -rf $HOME/.oh-my-zsh/custom
    ln -sf $DIR/omz $HOME/.oh-my-zsh/custom
  fi
else
  echo -e "${Red}zsh is not installed on this machine${NC}"
fi

# tmux
if [ ! -z "$(command -v tmux)" ]
then
  echo -e "${Green}tmux is installed, linking config${NC}"
  ln -fs $DIR/tmux.conf $HOME/.tmux.conf
else
  echo -e "${Red}tmux is not installed on this machine${NC}"
fi

##################################
# Files in the .config directory #
##################################
mkdir -p $HOME/.config

# kitty
if [ ! -z "$(command -v kitty)" ]
then
  echo -e "${Green}Kitty is installed, linking config${NC}"
  rm -rf $HOME/.config/kitty
  ln -sf $DIR/kitty $HOME/.config/kitty
else
  echo -e "${Red}Kitty is not installed on this machine${NC}"
fi

# hyprland
if [ ! -z "$(command -v Hyprland)" ]
then
  echo -e "${Green}Hyprland is installed, linking config${NC}"
  rm -rf $HOME/.config/hypr
  ln -sf $DIR/hypr $HOME/.config/hypr
else
  echo -e "${Red}Hyprland is not installed on this machine${NC}"
fi

# waybar
if [ ! -z "$(command -v waybar)" ]
then
  echo -e "${Green}Waybar is installed, linking config${NC}"
  rm -rf $HOME/.config/waybar
  ln -sf $DIR/waybar $HOME/.config/waybar
else
  echo -e "${Red}Waybar is not installed on this machine${NC}"
fi

# starship prompt
if [ ! -z "$(command -v starship)" ]
then
  echo -e "${Green}Starship is installed, linking config${NC}"
  ln -fs $DIR/starship.toml $HOME/.config/starship.toml
else
  echo -e "${Red}Starship is not installed on this machine${NC}"
fi

# spotifyd
if [ ! -z "$(command -v spotifyd)" ]
then
  echo -e "${Green}Spotifyd is installed, linking config${NC}"
  mkdir -p $HOME/.config/spotifyd
  ln -fs $DIR/spotifyd.conf $HOME/.config/spotifyd/spotifyd.conf
else
  echo -e "${Red}Spotifyd is not installed on this machine${NC}"
fi

##############
# vim config #
##############

if [ ! -z "$(command -v vim)" ]
then
  echo -e "${Green}Vim is installed, linking config${NC}"
  ln -fs $DIR/vimrc $HOME/.vimrc
  #mkdir -p $HOME/.vim/bundle
  if [ ! -z "$(command -v git)" ]
  then
    if ! test -d $HOME/.vim/bundle/Vundle.vim
    then
      echo "  Downloading plugin manager..."
      git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim &> /dev/null
    fi
    echo "  Installing plugins..."
    echo | vim +PluginInstall! +qall &> /dev/null
  else
    echo "git is needed to install the plugin manager"
  fi
else
  echo -e "${Red}Vim is not installed on this machine${NC}"
fi

####################
# ssh config files #
####################
if [ ! -z "$(command -v ssh)" ]
then
  echo -e "${Green}ssh is installed, linking config${NC}"
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
  echo -e "${Red}ssh is not installed on this machine${NC}"
fi

###############
# backgrounds #
###############

if [[ ! $DISPLAY =~ "localhost" ]]
then
  echo -e "${Green}Found graphical environment, linking backgrounds${NC}"
  rm -rf $XDG_PICTURES_DIR/wallpapers
  ln -sf $DIR/bg $XDG_PICTURES_DIR/wallpapers
fi

######
# DE #
######

if [ ! -z "$(command -v gnome-shell)" ]
then
  if [ ! -z "$(command -v dconf)" ]
  then
    echo -e "${Green}Gnome is installed, linking dconf config${NC}"
    dconf load / < $DIR/dconf-settings.ini
  fi
fi
