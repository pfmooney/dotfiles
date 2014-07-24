#!/bin/bash
DOTFILES=~/.dotfiles

flag="$@"
function relink() {
	ln -s -n -v $flag $2 $1
}

# Fetch git submodules
cd $DOTFILES
git submodule update --init


# setup links
cd
relink .bash_profile $DOTFILES/bash/profile
relink .bashrc $DOTFILES/bash/rc

relink .gitconfig $DOTFILES/gitconfig

relink .tmux.conf $DOTFILES/tmux/tmux.conf

relink .vim $DOTFILES/vim
relink .vimrc $DOTFILES/vim/vimrc
