#!/usr/bin/env sh


DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

###############################
# Files in the home directory #
###############################

# bashrc
if [ ! -z "$(which bash 2> /dev/null)" ]
then
  ln -fs $DIR/bashrc ~/.bashrc
fi

# zshrc
if [ ! -z "$(which zsh 2> /dev/null)" ]
then
  ln -fs $DIR/zshrc ~/.zshrc
fi

exit

# vim general config
ln -fs $DIR/vimrc ~/.vimrc
ln -fs $DIR/vimrc.bundles ~/.vimrc.bundles
rm -rf ~/.vim
ln -fs $DIR/vim ~/.vim

##################################
# Files in the .config directory #
##################################
mkdir -p ~/.config

# starship prompt
ln -fs $DIR/starship.toml ~/.config/starship.toml

# kitty
mkdir -p ~/.config/kitty
ln -fs $DIR/kitty.conf ~/.config/kitty/kitty.conf

# neovim
rm -rf ~/.config/nvim
ln -fs $DIR/nvim ~/.config/nvim

# i3
rm -rf ~/.config/i3
ln -fs $DIR/i3 ~/.config/i3

# Sway
rm -rf ~/.config/sway
ln -fs $DIR/i3 ~/.config/sway

# kitty
rm -rf ~/.config/kitty
ln -fs $DIR/kitty ~/.config/kitty

# polybar
rm -rf ~/.config/polybar
ln -fs $DIR/polybar ~/.config/polybar

###############
# backgrounds #
###############

# rm -rf ~/.config/bg
ln -sf $DIR/bg ~/Pictures/
