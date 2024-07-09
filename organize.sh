#!/usr/bin/env sh


DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

###############################
# Files in the home directory #
###############################

# bashrc
if [ ! -z "$(which bash 2> /dev/null)" ]
then
  echo "bash is installed, linking config"
  ln -fs $DIR/bashrc $HOME/.bashrc
else
  echo "bash is not installed on this machine"
fi

# zshrc
if [ ! -z "$(which zsh 2> /dev/null)" ]
then
  echo "zsh is installed, linking config"
  ln -fs $DIR/zshrc $HOME/.zshrc
else
  echo "zsh is not installed on this machine"
fi

##################################
# Files in the .config directory #
##################################
mkdir -p $HOME/.config

# kitty
if [ ! -z "$(which kitty 2> /dev/null)" ]
then
  echo "Kitty is installed, linking config"
  rm -rf $HOME/.config/kitty
  ln -sf $DIR/kitty $HOME/.config/kitty
else
  echo "Kitty is not installed on this machine"
fi

# hyprland
if [ ! -z "$(which Hyprland 2> /dev/null)" ]
then
  echo "Hyprland is installed, linking config"
  rm -rf $HOME/.config/hypr
  ln -sf $DIR/hypr $HOME/.config/hypr
else
  echo "Hyprland is not installed on this machine"
fi

# waybar
if [ ! -z "$(which waybar 2> /dev/null)" ]
then
  echo "Waybar is installed, linking config"
  rm -rf $HOME/.config/waybar
  ln -sf $DIR/waybar $HOME/.config/waybar
else
  echo "Waybar is not installed on this machine"
fi

# starship prompt
if [ ! -z "$(which kitty 2> /dev/null)" ]
then
  echo "Starship is installed, linking config"
  ln -fs $DIR/starship.toml $HOME/.config/starship.toml
else
  echo "Starship is not installed on this machine"
fi

####################
# ssh config files #
####################
if [ ! -z "$(which ssh 2> /dev/null)" ]
then
  echo "ssh is installed, linking config"
  mkdir -p $HOME/.ssh
  ln -fs $DIR/ssh/config $HOME/.ssh/config
  for f in ssh/*.pub
  do
    KEY_TAG=$(awk 'END {print $NF}' $f)
    if [ -z "$(grep $KEY_TAG $HOME/.ssh/authorized_keys)" ]
    then
      echo "  Adding $f to authorized keys"
      cat $f >> $HOME/.ssh/authorized_keys
    fi
  done
else
  echo "ssh is not installed on this machine"
fi

exit

# vim general config
ln -fs $DIR/vimrc $HOME/.vimrc
ln -fs $DIR/vimrc.bundles $HOME/.vimrc.bundles
rm -rf $HOME/.vim
ln -fs $DIR/vim $HOME/.vim

##################################
# Files in the .config directory #
##################################



# neovim
rm -rf $HOME/.config/nvim
ln -fs $DIR/nvim $HOME/.config/nvim

# i3
rm -rf $HOME/.config/i3
ln -fs $DIR/i3 $HOME/.config/i3

# Sway
rm -rf $HOME/.config/sway
ln -fs $DIR/i3 $HOME/.config/sway


# polybar
rm -rf $HOME/.config/polybar
ln -fs $DIR/polybar $HOME/.config/polybar

###############
# backgrounds #
###############

# rm -rf $HOME/.config/bg
ln -sf $DIR/bg $HOME/Pictures/
